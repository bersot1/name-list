// berso.aio.nameinlist

// .\keytool.exe -list -v -alias androiddebugkey -keystore "C:\Users\81011170\.android\debug.keystore"

// pegar senha sha1

// keytool -exportcert -alias androiddebugkey -keystore "C:\Users\81011170\.android\debug.keystore" | "C:\OpenSSL-Win64\bin\openssl" sha1 -binary | "C:\OpenSSL-Win64\bin\openssl" base64
