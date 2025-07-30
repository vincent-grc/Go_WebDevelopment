postgres:
	docker run --name postgres12 --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=rongcheng -d postgres:12-alpine
createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank
dropdb:
	docker exec -it postgres12 dropbd simple_bank
migrateup:
	migrate -path db/migration -database "postgres://root:8zTNUQkFCMBRiynKJud4@simple-bank.c0nmkoski5ju.us-east-1.rds.amazonaws.com:5432/simple_bank" -verbose up
migratedown:
	migrate -path db/migration -database "postgres://root:rongcheng@localhost:5432/simple_bank?sslmode=disable" -verbose down
migrateup1:
	migrate -path db/migration -database "postgres://root:rongcheng@localhost:5432/simple_bank?sslmode=disable" -verbose up 1
migratedown1:
	migrate -path db/migration -database "postgres://root:rongcheng@localhost:5432/simple_bank?sslmode=disable" -verbose down 1
sqlc:
	sqlc generate
test:
	go test -v -cover ./...
server:
	go run main.go
mock:
	mockgen -package mockdb -destination db/mock/store.go simpleBank/db/sqlc Store

.PHONY: postgres createdb dropbd migrateup migratedown sqlc test server mock migrateup1 migratedown1