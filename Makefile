build:
	@go build -o ./bin/tanso ./main.go

run: build
	@./bin/tanso

vault: build
	@./bin/tanso vault

new: build
	@./bin/tanso new

backlinks: build
	@./bin/tanso backlinks

clean: 
	@ rm -rf ~/.config/tanso/
