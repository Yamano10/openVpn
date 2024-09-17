auth required pam_ldap.so
account sufficient pam_permit.so

auth required pam_google_authenticator.so secret=/etc/openvpn/otp/${USER}.google_authenticator user=root forward_pass
auth required pam_ldap.so use_first_pass

account sufficient pam_permit.so
