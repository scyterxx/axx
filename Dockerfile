# --- STAGE 1: Build Aplikasi ---
FROM golang:1.20-alpine AS builder

WORKDIR /app

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .

# Build aplikasi Anda, pastikan outputnya sesuai dengan CMD di stage akhir
# Sesuaikan 'go-getting-started' dengan nama executable yang Anda inginkan
RUN go build -o /app/bin/go-getting-started .

# --- STAGE 2: Jalankan Aplikasi ---
FROM alpine:latest

# Copy executable dari stage builder ke stage runtime
COPY --from=builder /app/bin/go-getting-started /app/bin/go-getting-started

# Definisikan perintah untuk menjalankan aplikasi saat container dimulai
# Heroku akan secara otomatis menyuntikkan variabel lingkungan PORT saat runtime
CMD ["/app/bin/go-getting-started"]
