from os import listdir
from os.path import isdir, join

nodesDir = "modules/nodes/pages"

def generateIndexFile():
    path = nodesDir
    directories = [f for f in listdir(path) if isdir(join(path, f))]
    directories.sort()
    fileContent = rootIndexTemplate(directories)
    with open(join("modules/nodes", "nav.adoc"), "w", encoding="utf-8") as file:
        file.write(fileContent)


def rootIndexTemplate(categories):
    return f""".Nodes
{buildCategories(categories)}
"""


def buildCategories(categories):
    return "\n".join(map(generateCategoryContent, categories))


def generateCategoryContent(category):
    path = join(nodesDir, category)
    directories = [f for f in listdir(path) if isdir(join(path, f))]
    directories.sort()
    return categoryIndexTemplate(category, directories)


def categoryIndexTemplate(category, categories):
    return f"""* {category.title()}
{concatNodes(category, categories)}
"""


def concatNodes(category, entries):
    return "\n".join(map(includeTemplate(category), entries))


def includeTemplate(category):
    return lambda node: f"""** xref:nodes:{category}/{node}/index.adoc[]"""


generateIndexFile()
