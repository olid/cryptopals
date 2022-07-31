# Cryptopals
Slowly working my way through the [Cryptopals](https://cryptopals.com) challenges, implementing everything myself, including Base64 encoding/decoding,
AES etc.

## References
### AES
* [Main wiki page](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard)
* [Key Schedule](https://en.wikipedia.org/wiki/AES_key_schedule)
* [SBox reference](https://en.wikipedia.org/wiki/Rijndael_S-box)
* [Mix Columns reference](https://en.wikipedia.org/wiki/Rijndael_MixColumns)
* [Step-by-step guide with expected state values](https://www.kavaliro.com/wp-content/uploads/2014/03/AES.pdf) - there is a typo in one of the states,
  and remember that when this document says 'add' what it really means is 'xor'
