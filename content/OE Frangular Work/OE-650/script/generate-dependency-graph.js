const fs = require('fs');
const path = require('path');

const rootDir = path.resolve(__dirname, '..');
const templatesDir = path.join(rootDir, 'UI/Js/ConfigAdmin/Templates');
const cdnTemplatesDir = path.join(rootDir, '_cdn/Templates/ConfigAdmin');

function findDependencies(templatePath) {
    try {
        const content = fs.readFileSync(templatePath, 'utf8');
        const includes = content.match(/ng-include="[^"]+"|templateUrl:\s*['"][^'"]+['"]/g) || [];
        const dynamicIncludes = content.match(/getTemplate\([^)]+\)/g) || [];
        
        return {
            includes: includes.map(inc => {
                const match = inc.match(/"([^"]+)"|'([^']+)'/);
                return match ? match[1] || match[2] : null;
            }).filter(Boolean),
            dynamic: dynamicIncludes.map(inc => ({
                type: 'dynamic',
                source: inc.trim()
            }))
        };
    } catch (error) {
        console.error(`Error processing ${templatePath}:`, error.message);
        return { includes: [], dynamic: [] };
    }
}

function generateMermaidGraph() {
    let graph = 'graph TD\n';
    let processed = new Set();

    function processTemplate(templatePath, indent = '') {
        if (processed.has(templatePath)) return;
        processed.add(templatePath);

        const templateName = path.basename(templatePath);
        const deps = findDependencies(templatePath);

        deps.includes.forEach(inc => {
            const includePath = path.resolve(path.dirname(templatePath), inc);
            const includeName = path.basename(inc);
            graph += `${indent}${templateName} --> ${includeName}\n`;
            
            if (fs.existsSync(includePath)) {
                processTemplate(includePath, `${indent}    `);
            }
        });

        deps.dynamic.forEach(dynamic => {
            graph += `${indent}${templateName} -.-> Dynamic_${dynamic.source.replace(/[^a-zA-Z0-9]/g, '_')}\n`;
        });
    }

    // Process main templates with directory existence checks
    const templates = [];
    
    if (fs.existsSync(templatesDir)) {
        templates.push(...fs.readdirSync(templatesDir)
            .filter(f => f.endsWith('.html'))
            .map(f => path.join(templatesDir, f)));
    } else {
        console.warn(`Warning: Templates directory not found: ${templatesDir}`);
    }
    
    if (fs.existsSync(cdnTemplatesDir)) {
        templates.push(...fs.readdirSync(cdnTemplatesDir)
            .filter(f => f.endsWith('.html'))
            .map(f => path.join(cdnTemplatesDir, f)));
    } else {
        console.warn(`Warning: CDN Templates directory not found: ${cdnTemplatesDir}`);
    }

    if (templates.length === 0) {
        console.warn('No template files found in any directory');
        return 'graph TD\n    No_Templates[No template files found]';
    }

    templates.forEach(templatePath => {
        processTemplate(templatePath);
    });

    return graph;
}

try {
    const graphOutput = generateMermaidGraph();
    const outputPath = path.join(rootDir, 'template-dependencies.mmd');
    fs.writeFileSync(outputPath, graphOutput);
    console.log(`Dependency graph generated at: ${outputPath}`);
} catch (error) {
    console.error('Error generating dependency graph:', error.message);
    process.exit(1);
}