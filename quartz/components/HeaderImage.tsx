import { QuartzComponent, QuartzComponentConstructor, QuartzComponentProps } from "./types"
import fs from "fs"
import path from "path"

const HeaderImage: QuartzComponent = ({ fileData, cfg }: QuartzComponentProps) => {
  const folderPath = path.dirname(fileData.filePath!)
  const imageFiles = fs.readdirSync(folderPath).filter((file) => /\.(jpg|jpeg|png|gif|webp)$/.test(file))
  const imageUrl = imageFiles.length > 0 ? imageFiles[0] : null

  if (!imageUrl) {
    return null
  }

  return (
    <div class="page-header">
      <img src={`./${imageUrl}`} alt="Header Image" />
      <h1>{fileData.frontmatter?.title}</h1>
      <h2>{fileData.frontmatter?.subtitle}</h2>
    </div>
  )
}

HeaderImage.css = `
.page-header {
  position: relative;
  text-align: center;
  color: white;
  height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.page-header img {
  width: 100%;
  height: 100vh;
  object-fit: cover;
  position: absolute;
  top: 0;
  left: 0;
  z-index: -1;
}

.page-header h1,
.page-header h2 {
  margin: 0;
  padding: 0.5rem;
  background: rgba(0, 0, 0, 0.5);
  display: inline-block;
  width: auto;
}

.page-header h1 {
  font-size: 3rem;
  white-space: nowrap;
}

.page-header h2 {
  font-size: 2rem;
  white-space: nowrap;
}

@media (max-width: 600px) {
  .page-header h1 {
    font-size: 2rem;
  }

  .page-header h2 {
    font-size: 1.5rem;
  }
}
`

export default (() => HeaderImage) satisfies QuartzComponentConstructor