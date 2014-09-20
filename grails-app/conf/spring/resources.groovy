import org.apache.shiro.authc.credential.Sha256CredentialsMatcher

beans = {
	credentialMatcher(Sha256CredentialsMatcher) {
		storedCredentialsHexEncoded = true
	}
}
