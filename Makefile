build:
	@go build -o ./bin/tanso ./cmd/tanso/

run: build
	@./bin/tanso

build-vault:
	@go build -o ./bin/vault ./cmd/vault/

run-vault: build-vault
	@./bin/vault
	
clean: 
	@ rm -rf ~/.config/tanso/
