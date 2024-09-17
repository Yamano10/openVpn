# ReadMe

1\. Démarrer le Serveur VPN

```bash
sudo systemctl start openvpn@server
```

```bash
sudo systemctl status openvpn@server
```

2\. Configurer les Clients VPN  
Vous devez maintenant configurer les fichiers de configuration pour chaque client qui va se connecter au serveur VPN.

Créer un fichier de configuration pour le client :

1-Générez le fichier de configuration client : Vous devrez créer un fichier de configuration .ovpn pour chaque client. Voici un exemple de fichier de configuration pour un client. Ce fichier est basé sur les certificats que vous avez déjà générés avec Easy-RSA.

- Créez un fichier client1.ovpn :

```bash
sudo nano ~/client1.ovpn
```

2-Ajouter le contenu suivant au fichier client1.ovpn :

```bash
client
dev tun
proto udp
remote [Adresse_IP_du_Serveur] 1194
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
cipher AES-256-CBC
auth SHA256
compress lz4-v2
key-direction 1
verb 3
<ca>
-----BEGIN CERTIFICATE-----
# Collez ici le contenu de votre fichier ca.crt
-----END CERTIFICATE-----
</ca>
<cert>
-----BEGIN CERTIFICATE-----
# Collez ici le contenu de votre certificat client1.crt
-----END CERTIFICATE-----
</cert>
<key>
-----BEGIN PRIVATE KEY-----
# Collez ici le contenu de votre clé privée client1.key
-----END PRIVATE KEY-----
</key>
<tls-auth>
-----BEGIN OpenVPN Static key V1-----
# Collez ici le contenu de votre fichier ta.key
-----END OpenVPN Static key V1-----
</tls-auth>
```

3-Copier les fichiers nécessaires au client : Vous devez copier les fichiers de certificat suivants générés par Easy-RSA sur l'appareil client (ordinateur, téléphone, etc.) :

- ca.crt
- client1.crt
- client1.key
- client1.ovpn (fichier de configuration que vous venez de créer)  
  Utilisez SCP (Secure Copy) ou un autre moyen sécurisé pour copier ces fichiers sur l'appareil client.

4-Installer OpenVPN sur le Client :

Sur Linux/Ubuntu :

```bash
sudo apt install openvpn
```

- Sur Windows : Téléchargez et installez le client OpenVPN.
    
- Sur macOS : Utilisez Tunnelblick, un client OpenVPN pour macOS.
    
- Sur Android/iOS : Téléchargez l'application OpenVPN Connect depuis le Google Play Store ou l'App Store.  
    5- Importer le fichier .ovpn dans l'application OpenVPN :
    
- Une fois OpenVPN installé sur le client, ouvrez l'application et importez le fichier client1.ovpn.
    

6-Se connecter au VPN :

- Utilisez l'interface du client OpenVPN pour vous connecter au serveur VPN.
- Si la connexion réussit, vous serez connecté au réseau privé du VPN.

3.  Vérification et Dépannage  
    1-Vérifiez les journaux sur le serveur : Si vous avez des problèmes pour vous connecter, vous pouvez vérifier les journaux OpenVPN sur le serveur pour voir ce qui se passe :

```bash
sudo tail -f /var/log/openvpn.log
```

2-Vérifiez les journaux sur le client :

- Sur Windows/macOS, les journaux sont disponibles via l'interface OpenVPN.
- Sur Linux, exécutez OpenVPN avec le fichier de configuration client et surveillez les journaux en ligne de commande :

```bash
sudo openvpn --config ~/client1.ovpn
```

4.  Configurer le Pare-feu pour Permettre les Connexions VPN  
    Si vous avez configuré un pare-feu (comme UFW), assurez-vous d'avoir les bonnes règles pour autoriser les connexions OpenVPN.

- Autorisez les connexions sur le port VPN (1194 UDP) :

```bash
sudo ufw allow 1194/udp
```

- Autorisez uniquement les connexions HTTP via VPN :

```bash
sudo ufw allow 80/tcp
```

5.  Activer l'Authentification à Deux Facteurs (2FA)  
    Si vous avez activé l'authentification à deux facteurs (Google Authenticator), chaque utilisateur doit entrer un code de vérification en plus de son certificat pour se connecter au VPN.

1-Générer un code QR pour chaque utilisateur :

- Sur le serveur, connectez-vous en tant qu'utilisateur VPN et exécutez :

```bash
google-authenticator


```

2-L'utilisateur doit scanner le code QR avec Google Authenticator (ou une autre application 2FA) pour recevoir un code de vérification.

3-Lors de la connexion, l'utilisateur entre le code généré par l'application pour se connecter au VPN.

Résumé :  
Démarrez le serveur OpenVPN sur votre machine principale.  
Générez les fichiers de configuration pour les clients et importez-les sur les appareils clients.  
Connectez les appareils clients en utilisant le fichier de configuration .ovpn.  
Assurez-vous que les bonnes règles de pare-feu sont configurées pour autoriser le trafic VPN et HTTP.  
Si l'authentification à deux facteurs est activée, chaque utilisateur doit fournir un code de vérification avant de se connecter.  
En suivant ces étapes, vous pourrez faire fonctionner votre serveur VPN OpenVPN et permettre à vos clients de se connecter de manière sécurisée.
