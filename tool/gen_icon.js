// Generates the Aurum app-icon PNGs with zero external dependencies.
// Draws a gold "A" monogram on a deep-navy background.
//
//   node tool/gen_icon.js
//
// Outputs:
//   assets/icon/aurum_icon.png        full-bleed icon (iOS + legacy Android)
//   assets/icon/aurum_foreground.png  transparent A for Android adaptive icon
//   assets/icon/aurum_mono.png        white A on transparent (in-app logo use)

const fs = require('fs');
const path = require('path');
const zlib = require('zlib');

const SIZE = 1024;

// ---- tiny PNG encoder (RGBA, 8-bit) -----------------------------------------
function crc32(buf) {
  let c = ~0;
  for (let i = 0; i < buf.length; i++) {
    c ^= buf[i];
    for (let k = 0; k < 8; k++) c = (c >>> 1) ^ (0xedb88320 & -(c & 1));
  }
  return ~c >>> 0;
}
function chunk(type, data) {
  const len = Buffer.alloc(4);
  len.writeUInt32BE(data.length, 0);
  const typeBuf = Buffer.from(type, 'ascii');
  const crc = Buffer.alloc(4);
  crc.writeUInt32BE(crc32(Buffer.concat([typeBuf, data])), 0);
  return Buffer.concat([len, typeBuf, data, crc]);
}
function encodePng(pixels, w, h) {
  const ihdr = Buffer.alloc(13);
  ihdr.writeUInt32BE(w, 0);
  ihdr.writeUInt32BE(h, 4);
  ihdr[8] = 8; // bit depth
  ihdr[9] = 6; // color type RGBA
  // 10,11,12 = compression, filter, interlace = 0
  const raw = Buffer.alloc(h * (w * 4 + 1));
  for (let y = 0; y < h; y++) {
    raw[y * (w * 4 + 1)] = 0; // filter: none
    pixels.copy(raw, y * (w * 4 + 1) + 1, y * w * 4, (y + 1) * w * 4);
  }
  return Buffer.concat([
    Buffer.from([0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]),
    chunk('IHDR', ihdr),
    chunk('IDAT', zlib.deflateSync(raw, { level: 9 })),
    chunk('IEND', Buffer.alloc(0)),
  ]);
}

// ---- drawing helpers --------------------------------------------------------
const lerp = (a, b, t) => a + (b - a) * t;
const clamp01 = (t) => (t < 0 ? 0 : t > 1 ? 1 : t);
const hex = (h) => [
  parseInt(h.slice(1, 3), 16),
  parseInt(h.slice(3, 5), 16),
  parseInt(h.slice(5, 7), 16),
];

// distance from point p to segment ab
function distToSeg(px, py, ax, ay, bx, by) {
  const dx = bx - ax, dy = by - ay;
  const len2 = dx * dx + dy * dy || 1;
  let t = ((px - ax) * dx + (py - ay) * dy) / len2;
  t = clamp01(t);
  const cx = ax + t * dx, cy = ay + t * dy;
  return Math.hypot(px - cx, py - cy);
}

// Smooth coverage for anti-aliasing around an edge at `d` (signed: <0 inside).
const aa = (d) => clamp01(0.5 - d); // 1px feather

// Geometry of the "A" within a `scale` (fraction of canvas) centred.
function letterA(scale) {
  const c = SIZE / 2;
  const half = (SIZE * scale) / 2;
  const top = c - half, bot = c + half;
  const apexX = c, apexY = top;
  const legSpread = half * 0.92;
  const stroke = SIZE * scale * 0.165;
  const lInX = c - legSpread, rInX = c + legSpread;
  // crossbar sits ~62% down
  const barY = lerp(top, bot, 0.64);
  const segs = [
    [apexX, apexY, lInX, bot], // left leg
    [apexX, apexY, rInX, bot], // right leg
  ];
  return { segs, stroke, barY, apexX, apexY, lInX, rInX, bot };
}

function coverageA(x, y, geo) {
  const r = geo.stroke / 2;
  let cov = 0;
  for (const [ax, ay, bx, by] of geo.segs) {
    cov = Math.max(cov, aa(distToSeg(x, y, ax, ay, bx, by) - r));
  }
  // crossbar between the two legs at barY
  const t = (geo.barY - geo.apexY) / (geo.bot - geo.apexY);
  const lx = lerp(geo.apexX, geo.lInX, t);
  const rx = lerp(geo.apexX, geo.rInX, t);
  const barCov =
    aa(distToSeg(x, y, lx, geo.barY, rx, geo.barY) - geo.stroke * 0.42);
  cov = Math.max(cov, barCov);
  return cov;
}

function render({ background, foregroundOnly, letterScale, letterColorTop, letterColorBot, padForeground }) {
  const px = Buffer.alloc(SIZE * SIZE * 4);
  const geo = letterA(letterScale);
  const bgTop = background ? hex(background[0]) : null;
  const bgBot = background ? hex(background[1]) : null;
  const gTop = hex(letterColorTop);
  const gBot = hex(letterColorBot);
  for (let y = 0; y < SIZE; y++) {
    const vy = y / (SIZE - 1);
    for (let x = 0; x < SIZE; x++) {
      const i = (y * SIZE + x) * 4;
      // base background
      let r = 0, g = 0, b = 0, a = 0;
      if (!foregroundOnly) {
        r = lerp(bgTop[0], bgBot[0], vy);
        g = lerp(bgTop[1], bgBot[1], vy);
        b = lerp(bgTop[2], bgBot[2], vy);
        a = 255;
      }
      // letter
      const cov = coverageA(x, y, geo);
      if (cov > 0) {
        // gold gradient along the letter's vertical extent
        const lt = clamp01((y - geo.apexY) / (geo.bot - geo.apexY));
        const lr = lerp(gTop[0], gBot[0], lt);
        const lg = lerp(gTop[1], gBot[1], lt);
        const lb = lerp(gTop[2], gBot[2], lt);
        if (foregroundOnly) {
          r = lr; g = lg; b = lb; a = Math.max(a, Math.round(cov * 255));
        } else {
          r = lerp(r, lr, cov);
          g = lerp(g, lg, cov);
          b = lerp(b, lb, cov);
        }
      }
      px[i] = Math.round(r);
      px[i + 1] = Math.round(g);
      px[i + 2] = Math.round(b);
      px[i + 3] = Math.round(a);
    }
  }
  return px;
}

const outDir = path.join(__dirname, '..', 'assets', 'icon');
fs.mkdirSync(outDir, { recursive: true });

const GOLD_TOP = '#F4D58D';
const GOLD_BOT = '#C8902B';
const NAVY = ['#1B2350', '#0C1130'];

// 1) Full icon — navy bg + gold A (iOS & legacy Android)
fs.writeFileSync(
  path.join(outDir, 'aurum_icon.png'),
  encodePng(render({ background: NAVY, letterScale: 0.62, letterColorTop: GOLD_TOP, letterColorBot: GOLD_BOT }), SIZE, SIZE)
);

// 2) Adaptive foreground — transparent, smaller A (safe zone padding)
fs.writeFileSync(
  path.join(outDir, 'aurum_foreground.png'),
  encodePng(render({ foregroundOnly: true, letterScale: 0.42, letterColorTop: GOLD_TOP, letterColorBot: GOLD_BOT }), SIZE, SIZE)
);

// 3) Monochrome white A on transparent (for in-app use if wanted)
fs.writeFileSync(
  path.join(outDir, 'aurum_mono.png'),
  encodePng(render({ foregroundOnly: true, letterScale: 0.62, letterColorTop: '#FFFFFF', letterColorBot: '#FFFFFF' }), SIZE, SIZE)
);

console.log('Wrote icons to', outDir);
