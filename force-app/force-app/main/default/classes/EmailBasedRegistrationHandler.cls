global class EmailBasedRegistrationHandler implements Auth.RegistrationHandler {

    global User createUser(Id portalId, Auth.UserData data) {
        // Pokus o nalezení existujícího uživatele podle emailu


        String idToken = data.attributeMap.get('idToken');
        String csobUsername = getOnPremIdentity(idToken);
   
       
        List<User> users = [SELECT Id FROM User WHERE username = :csobUsername LIMIT 1];
        if (!users.isEmpty()) {
            return users[0];
        } else {
            // Uživatel nenalezen – případně vytvořte nového
            return null;
        }

    }

    global void updateUser(Id userId, Id portalId, Auth.UserData data) {

        System.debug(LoggingLevel.INFO, 'OnPremIdentity: ' + getOnPremIdentity(data.idToken));
                 
        
    }
    
    global string getOnPremIdentity(string idToken)
    {
        List<String> parts = idToken.split('\\.');
        if (parts.size() != 3) {
            throw new IllegalArgumentException('Invalid JWT format');
        }

        // Dekóduj payload (část 2)
        String payloadBase64 = parts[1];
        String payloadJson = EncodingUtil.urlDecode(
            EncodingUtil.base64Decode(payloadBase64).toString(), 'UTF-8'
        );

        // Parsuj JSON
        Map<String, Object> payloadMap = (Map<String, Object>) JSON.deserializeUntyped(payloadJson);


       return String.valueOf(payloadMap.get('OnPremIdentity'));

    }
   
}