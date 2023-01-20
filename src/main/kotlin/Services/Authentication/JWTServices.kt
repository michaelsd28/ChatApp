package Services.Authentication
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import model.UserLogin
import java.security.Key;


object JWTServices {

    val secret_key:String = "secret key for jwt token generation and validation 2"
    //The specified key byte array is 48 bits which is not secure enough for any JWT HMAC-SHA algorithm.  The JWT JWA Specification (RFC 7518, Section 3.2) states that keys used with HMAC-SHA algorithms MUST have a size >= 256 bits (the key size must be greater than or equal to the hash output size).


    fun generateJWTToken(user: UserLogin): String {

        val key: Key = Keys.hmacShaKeyFor(secret_key.toByteArray())

        val jwt = Jwts.builder()
            .setSubject(user.username)
            .signWith(key)
            .compact()

        return jwt

    }

    fun validateJWTToken(token: String): Boolean {
        val key: Key = Keys.hmacShaKeyFor(secret_key.toByteArray())

        return try {
            Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token)
            true
        } catch (e: Exception) {
            print("validateJWTToken: $e")
            false
        }

    }

    fun getUsernameFromJWTToken(token: String): String {
        val key: Key = Keys.hmacShaKeyFor(secret_key.toByteArray())

        return try {
            Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token).body.subject
        } catch (e: Exception) {
            ""
        }

    }




}