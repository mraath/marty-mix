import { QuartzComponent, QuartzComponentConstructor, QuartzComponentProps } from "./types"
import fs from "fs"
import path from "path"
import matter from "gray-matter"
import { h } from "preact"

const HeaderImage: QuartzComponent = ({ fileData, cfg }: QuartzComponentProps) => {
  const folderPath = path.dirname(fileData.filePath!)
  const imageFiles = fs.readdirSync(folderPath).filter((file) => /\.(jpg|jpeg|png|gif|webp)$/.test(file))
  const imageUrl = imageFiles.length > 0 ? imageFiles[0] : null

  if (!imageUrl) {
    return null
  }

  // Parse the Markdown content to find the first H1 and H2 headers
  const content = matter(fileData.content).content
  const h1Match = content.match(/^#\s+(.*)$/m)
  const h2Match = content.match(/^##\s+(.*)$/m)
  const title = h1Match ? h1Match[1] : "Default Title"
  const subtitle = h2Match ? h2Match[1] : "Default Subtitle"

  return (
    <>
      <div class="page-header">
        <img src={`./${imageUrl}`} alt="Header Image" />
        <h1>{title}</h1>
        <h2>{subtitle}</h2>
      </div>
      <div class="page-content">
        <div dangerouslySetInnerHTML={{ __html: fileData.content }} />
      </div>
    </>
  )
}

HeaderImage.css = `
html, body {
  margin: 0;
  padding: 0;
  height: 100%;
}

.page-header {
  position: relative;
  text-align: center;
  color: white;
  height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  margin: 0; /* Remove any margin */
}

.page-header img {
  width: 100%;
  height: 100vh;
  object-fit: cover;
  position: fixed; /* Ensure the image covers the entire viewport */
  top: 0;
  left: 0;
  z-index: -1;
}

.page-header h1,
.page-header h2 {
  margin: 0;
  padding: 0.5rem;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5); /* Add text shadow */
  display: inline-block;
  width: auto;
  background: none; /* Ensure no background color */
}

.page-header h1 {
  font-size: 3rem;
  white-space: nowrap;
}

.page-header h2 {
  font-size: 2rem;
  white-space: nowrap;
}

.page-content {
  padding-top: 100vh; /* Ensure content starts after the header image */
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