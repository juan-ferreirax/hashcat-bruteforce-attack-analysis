#!/bin/bash

# --- Extração dos Hashes para o Teste ---
#1. É necessário ter o utilitário CLI do John the Ripper para extração dos hashes
#2. Talvez seja necessário adicionar o sufixo .pl ou .py depois do início da invocação do comando
#3. Para uso do hash no utilitário CLI do Hashcat é conveniente salvar o hash em um arquivo de texto
#4. Talvez seja necessário formatar o Hash após a extração no arquivo de texto para que seja compatível com o Hashcat.

# 1. Arquivos ZIP
# Extrai o hash do ZIP com criptografia legada (ZipCrypto)
zip2john zip_ZipCrypto.zip > hash_zip_crypto.txt

# Extrai o hash do ZIP com criptografia moderna (AES-256)
zip2john zip_AES256.zip > hash_zip_aes256.txt

# 2. Arquivos RAR
# Extrai o hash do RAR legado (RAR4)
rar2john rar4_AES128.rar > hash_rar4.txt

# Extrai o hash do RAR moderno (RAR5)
rar2john rar5_AES256.rar > hash_rar5.txt

# 3. Arquivo 7z
# Extrai o hash do arquivo 7z
7z2john.pl 7z_AES256.7z > hash_7z.txt

echo "Processo de extração de hashes concluído"