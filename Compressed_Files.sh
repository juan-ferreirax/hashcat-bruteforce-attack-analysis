#!/bin/bash

# --- Criação de Arquivos Compactados com Senha e Criptografia ---
#1. Foi utilizado o arquivo file.txt disponível nesse repositório para criação #dos arquivos compactados
#2. As versões mais recentes do Winrar não suportam mais a criação de arquivos #no formato RAR4 Legado, foi utilizado a v5.5.0 do utilitário RAR disponível #nesse repositório.
#3. Para a criação do arquivo compactado no formato .7z é necessário ter o #utilitário CLI instalado.
#4. Utilitário CLI do 7z pode ser instalado em distros linux baseadas em #Debian(Ubuntu, ZorinOS, Kali, Mint etc) através do comando "sudo apt install #p7zip-full"

# 1. ZIP Legado (ZipCrypto)
zip -e zip_ZipCrypto.zip file.txt

# 2. ZIP Moderno (AES-256)
7z a -p -mem=AES256 zip_AES256.zip file.txt

# 3. RAR Legado (Formato RAR4)
/home/username/rar_legacy_test/rar a -p -hp -ma4 rar4_AES128.rar file.txt

# 4. RAR Moderno (Formato RAR5)
rar a -p -hp rar5_AES256.rar file.txt

# 5. 7z Moderno (AES-256)
7z a -p 7z_AES256.7z file.txt

echo "Os 5 arquivos compactados foram criados com sucesso usando file.txt"