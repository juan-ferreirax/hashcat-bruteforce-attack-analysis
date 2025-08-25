#!/bin/bash

#RODE CADA COMANDO INDIVIDUALMENTE!
# Os comandos seguem a seguinte estrutura:
# -m xxxxx: Especifica o modo de hash para o formato especificado.
# -a 3: Define o modo de ataque como "Brute-force". 
# hashfile.txt: O arquivo que contém o hash extraído.
# ?d?d?d?d?d?d?d?d?d: A máscara do ataque, representando 9 dígitos(0-9).

#1. Para o arquivo 7-Zip (hash_7z.txt)
#Este comando utiliza o modo para hashes do 7-Zip (-m 11600) para atacar o hash #contido no arquivo hash_7z.txt.

hashcat -m 11600 -a 3 hash_7z.txt ?d?d?d?d?d?d?d?d?d

#2. Para o arquivo RAR5 (hash_rar5.txt)
#Este comando utiliza o modo para hashes do RAR5 (-m 13000) para atacar o hash #contido no arquivo hash_rar5.txt.

hashcat -m 13000 -a 3 hash_rar5.txt ?d?d?d?d?d?d?d?d?d

#3. Para o arquivo RAR4 (hash_rar4.txt)
#Este comando utiliza o modo para hashes do RAR3-p (-m 12500) para atacar o hash #contido no arquivo hash_rar4.txt.

hashcat -m 12500 -a 3 hash_rar4.txt ?d?d?d?d?d?d?d?d?d

#4. Para o arquivo ZIP com AES-256 (hash_zip_aes256.txt)
#Este comando utiliza o modo para hashes do WinZip (-m 13600) para atacar o hash #contido no arquivo hash_zip_aes256.txt.

hashcat -m 13600 -a 3 hash_zip_aes256.txt ?d?d?d?d?d?d?d?d?d

#5. Para o arquivo ZIP legado (ZipCrypto) (hash_zip_crypto.txt)
#Este comando utiliza o modo para hashes do PKZIP (Master Key) (-m 17200) para #atacar o hash contido no arquivo hash_zip_crypto.txt.

hashcat -m 17200 -a 3 hash_zip_crypto.txt ?d?d?d?d?d?d?d?d?d