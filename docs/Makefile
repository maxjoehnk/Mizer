.PHONY: build index_files

build: index_files npm_install
	npm run build

npm_install:
	npm install

index_files:
	python3 create_index_files.py
