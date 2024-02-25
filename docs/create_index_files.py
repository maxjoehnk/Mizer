from os import listdir
from os.path import isdir, join


def rootIndexTemplate(categories):
    return f"""= Nodes
:toc:
:toclevels: 2
ifndef::imagesdir[:imagesdir: ../]

{concatList(categories, 1)}
"""


def categoryIndexTemplate(category, categories):
    return f"""= {category.title()}
ifndef::imagesdir[:imagesdir: ../../]

{concatList(categories, 1)}
"""


def includeTemplate(offset):
    return lambda category: f"""include::{category}/index.adoc[leveloffset=+{offset}]"""


def concatList(entries, offset):
    return "\n".join(map(includeTemplate(offset), entries))


def generateIndexFile():
    path = "nodes"
    directories = [f for f in listdir(path) if isdir(join(path, f))]
    directories.sort()
    fileContent = rootIndexTemplate(directories)
    with open(join(path, "index.adoc"), "w", encoding="utf-8") as file:
        file.write(fileContent)


def generateCategoryFile(category):
    path = f"nodes/{category}"
    directories = [f for f in listdir(path) if isdir(join(path, f))]
    directories.sort()
    fileContent = categoryIndexTemplate(category, directories)
    with open(join(path, "index.adoc"), "w", encoding="utf-8") as file:
        file.write(fileContent)


generateIndexFile()
directories = [f for f in listdir("nodes") if isdir(join("nodes", f))]

for category in directories:
    generateCategoryFile(category)
