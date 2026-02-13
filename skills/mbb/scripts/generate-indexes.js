const fs = require("fs");
const path = require("path");

const ROOT = path.resolve(__dirname, "..", "skills");
const INDEX_DIR = path.join(ROOT, "index");

const SECTIONS = [
  { title: "Architecture", dir: "architecture" },
  { title: "Components", dir: "components" },
  { title: "UX", dir: "ux" },
  { title: "Cache", dir: "cache" },
  { title: "Metrics", dir: "metrics" },
  { title: "Integrations", dir: "integrations" },
  { title: "Libraries", dir: "libs" },
];

function readTitle(filePath) {
  const content = fs.readFileSync(filePath, "utf8");
  const match = content.match(/^#\s+(.+)$/m);
  if (match) return match[1].trim();
  return path.basename(filePath, ".md");
}

function listMarkdownFiles(dirPath) {
  if (!fs.existsSync(dirPath)) return [];
  return fs
    .readdirSync(dirPath)
    .filter((file) => file.endsWith(".md"))
    .filter((file) => !file.startsWith("index-"))
    .sort((a, b) => a.localeCompare(b, "ru"));
}

function renderIndex() {
  const lines = [];
  lines.push("# Index: MBB-specific Skills");
  lines.push("");
  lines.push("> Навигационный индекс по MBB-специфичным skills");
  lines.push("");

  SECTIONS.forEach((section) => {
    const sectionDir = path.join(ROOT, section.dir);
    const files = listMarkdownFiles(sectionDir);
    lines.push(`## ${section.title}`);
    lines.push("");
    if (files.length === 0) {
      lines.push("- _Пока нет skills_");
      lines.push("");
      return;
    }
    files.forEach((file) => {
      const fullPath = path.join(sectionDir, file);
      const title = readTitle(fullPath);
      const rel = `../${section.dir}/${file}`;
      lines.push(`- [\`${title}\`](${rel})`);
    });
    lines.push("");
  });

  lines.push("## Related");
  lines.push("");
  lines.push("- Общие skills: [`../skills/`](../../skills/)");
  lines.push("");

  return lines.join("\n");
}

function writeIndex() {
  const content = renderIndex();
  const target = path.join(INDEX_DIR, "index-mbb.md");
  fs.writeFileSync(target, content, "utf8");
}

writeIndex();
console.log("Index generated.");
