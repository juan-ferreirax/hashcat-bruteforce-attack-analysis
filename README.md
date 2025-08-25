# Análise de Ataques de Força Bruta com o Software Hashcat

## ⚠️ Aviso Ético

Este projeto foi realizado para fins puramente educacionais e de estudo. As ferramentas e técnicas aqui descritas devem ser utilizadas apenas em ambientes controlados e em ficheiros de sua propriedade. A quebra de senhas em sistemas ou ficheiros para os quais você não tem autorização explícita é ilegal.

## 📄 Resumo dos Resultados

| Formato / Encriptação    | Tempo para Quebrar (Senha de 9 dígitos) |
| ------------------------ | --------------------------------------- |
| ZIP (Legado - ZipCrypto) | ~2 segundos                             |
| ZIP (Moderno - AES256)   | 2 minutos e 10 segundos                 |
| RAR (Moderno - RAR5)     | 2 horas e 32 minutos                    |
| RAR (Legado - RAR4)      | 2 horas e 59 minutos                    |
| 7z (Moderno - AES256)    | 10 horas e 53 minutos                   |

## ⚙️ Setup de Teste

**👨🏻‍💻 Softwares:** Hashcat v6.2.6 e John the Ripper v1.9.0  
**🐧 Sistema Operacional:** Ubuntu LTS 24.04.2  
**⚙️ Hardware:** GPU Nvidia Geforce RTX 3050 6GB  
**🛠️ Drivers:** NVIDIA Driver v580.65.06, CUDA Toolkit v13.0  
**🗃️ Arquivos Compactados:** 2 arquivos .zip, 2 arquvios .rar e 1 arquivo .7z

## \#️⃣Metodologia e Comandos

### Script para criar os 5 arquivos de teste com uma senha de 9 dígitos:

```
# --- Criação de arquivos compactados com senha e criptografia ---
#1. Foi utilizado o arquivo file.txt disponível nesse repositório para criação dos arquivos compactados
#2. As versões mais recentes do Winrar não suportam mais a criação de arquivos no formato RAR4 Legado, foi utilizado a v5.5.0 do utilitário RAR disponível nesse repositório.
#3. Para a criação do arquivo compactado no formato .7z é necessário ter o utilitário CLI instalado.
#4. Utilitário CLI do 7z pode ser instalado em distros linux baseadas em Debian(Ubuntu, ZorinOS, Kali, Mint etc) através do comando "sudo apt install p7zip-full"

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
```

### Script para extrair os hashes usando o software John the Ripper:

```
# --- Extração dos Hashes para o Projeto ---
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

```

### Ataque com Hashcat:
```
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

```

## 📜 Análise e Conclusões

#### ZIP (Legado - ZipCrypto) 

**Tempo para Quebrar:** Menos de 2 segundos.

**Análise:** Trivial. Nenhuma barreira real para um ataque moderno. O algoritmo Zipcripto criado em 1989 era relativamente resistente para o hardware disponível na época, porém tinha diversas falhas de design desde a sua criação sendo uma delas a vulnerabilidade ```Known-Plaintext Attack``` onde bastava o atacante ter uma cópia não encriptada de um dos arquivos dentro do ficheiro para deduzir a chave que liberava o acesso do ficheiro inteiro.

### ZIP (Moderno - AES256)

**Tempo para Quebrar:** 2 minutos e 10 segundos.

**Análise:** O padrão mínimo aceitável hoje, mas ainda vulnerável a ataques focados. Percebendo a fraqueza do ZipCrypto, a especificação do formato ZIP foi oficialmente atualizada no ano de 2003 para incluir a encriptação AES (Advanced Encryption Standard). Programas como o WinZip 9.0 foram pioneiros na implementação desta nova especificação que representou um salto gigantesco em segurança para o formato.

#### RAR (Moderno - RAR5)

**Tempo para Quebrar:** 2 horas e 32 minutos.

Análise: Um salto enorme em robustez, começando a tornar o ataque de força bruta dispendioso. Lançado com o WinRAR 5.0 em 2013, o novo formato RAR5 foi uma reconstrução significativa. As principais melhorias de segurança foram a adoção do AES-256 como padrão e, crucialmente, a implementação de um algoritmo de derivação de chave (KDF) mais robusto e lento, projetado para dificultar ataques de força bruta com hardware moderno como GPUs.

### RAR (Legado - RAR4)

**Tempo para Quebrar:** 2 horas e 59 minutos.

**Análise:** Um resultado um tanto quanto inesperado, mesmo sendo legado ele demorou mais tempo para ser quebrado, pesquisando mais sobre, descobri que o seu algoritmo (KDF) provou ser menos otimizado para o paralelismo das GPUs modernas, resistindo assim por mais tempo do que o seu sucessor. Uma prova de que nem sempre "mais novo" significa "mais rápido de atacar". Lançado com o WinRAR 3.0, este foi um marco pois introduziu o formato de arquivo RAR3 (que hoje chamamos de RAR4 para diferenciar do RAR5). A grande novidade de segurança foi a introdução da encriptação AES-128, tornando-o muito mais seguro que o ZipCrypto da época.

### 7z (Moderno - AES256)

**Tempo para Quebrar:** 10 horas e 53 minutos.

**Análise:** O campeão indiscutível. O tempo de quebra é drasticamente maior. Uma demonstração clara da força do seu design de segurança. O 7z "nasceu" em 2001 já com a melhor tecnologia de criptografia simétrica disponível na época (AES) como padrão. Ao escolher o AES-256, Igor Pavlov(Criador do software 7-zip) não estava apenas a pensar na segurança do presente, mas estava a construir uma base que permaneceria segura por décadas.

### Diferença nos Tempos de Ataque

A diferença brutal nos tempos, especialmente para o 7z, não se deve apenas ao algoritmo de encriptação que é maioritariamente AES, mas à sua Função de Derivação de Chave (KDF). Formatos modernos como o 7z forçam o atacante a um trabalho computacional pesado e lento para CADA tentativa. O KDF do 7z "martela" cada palpite mais de 500.000 vezes, tornando o processo extremamente caro e ineficiente para o atacante. Isso explica o porque dos atacantes  preferirem recorrer por exemplo a ataques de engenharia social ao invés de ataques de força bruta.

### Conclusão e Conselhos Práticos:

O comprimento sem complexidade é uma ilusão de segurança. Mesmo utilizando o 7z, se a sua senha tiver **baixa complexidade**(falta de variedade nos tipos de caracteres utilizados) ou **baixa entropia**(grau de aleatoriedade baixo) ela poderá ser vulnerável a ataques de força bruta.

**Para proteger os seus dados de verdade:**

**Use senhas complexas:** Misture letras MAIÚSCULAS, minúsculas, números e símbolos!@#. Uma senha como Casa@Forte!25 levaria centenas de anos a ser quebrada.

**Use ferramentas modernas:** Ao proteger arquivos, dê preferência ao formato .7z. O seu design de segurança provou ser superior em relação ao ZIP e ao formato proprietário RAR.

**Adote um gestor de senhas:** É a forma mais inteligente de gerir credenciais fortes e únicas. Existem diversas opções no mercado tais como Bitwarden e 1Password.