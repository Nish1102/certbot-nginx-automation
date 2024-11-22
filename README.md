### **Step 1: Create the Renewal Script**
Run the following command to create the renewal script:
```bash
sudo nano /usr/local/bin/renew_certificates.sh
```

Add the following content to the script:
```bash
#!/bin/bash

# Renew certificates
/usr/local/bin/certbot renew --quiet --no-self-upgrade

# Reload Nginx to apply the renewed certificates
systemctl reload nginx

# Log the renewal attempt
echo "$(date): Certificate renewal attempted." >> /var/log/certbot-renew.log
```

Save and exit (`CTRL + O`, `Enter`, `CTRL + X`).

Make the script executable:
```bash
sudo chmod +x /usr/local/bin/renew_certificates.sh
```

---

### **Step 2: Schedule the Cron Job**
Edit the `root` crontab:
```bash
sudo crontab -e
```

Add the following line to run the script daily at 3:00 AM:
```bash
0 3 * * * /usr/local/bin/renew_certificates.sh >> /var/log/certbot-renew.log 2>&1
```

Save and exit (`CTRL + O`, `Enter`, `CTRL + X` in `nano` or `:wq` in `vim`).

This ensures the script is executed daily, but certificates will only be renewed if they are due (within 30 days of expiration).

---

### **Step 3: Create the Log File**
Manually create the log file to ensure it exists and is writable:
```bash
sudo touch /var/log/certbot-renew.log
sudo chmod 644 /var/log/certbot-renew.log
```

---

### **Step 4: Test the Renewal Script**
Run the script manually to confirm it works:
```bash
sudo /usr/local/bin/renew_certificates.sh
```

---

### **Step 5: Check the Log File**
After running the script, verify that the attempt is logged:
```bash
cat /var/log/certbot-renew.log
```

You should see an entry like:
```
Tue Nov 22 12:34:56 UTC 2024: Certificate renewal attempted.
```

---

### **Step 6 (Optional): Set Up Email Notifications**
If you want email notifications about renewal issues, register your email with `certbot`:
```bash
sudo certbot register --email your-email@example.com --agree-tos
```

This step ensures you are notified if any issues arise during the renewal process.

---

### Final Notes
- The cron job ensures certificates are renewed automatically and applied without manual intervention.
- Logs are maintained in `/var/log/certbot-renew.log` for debugging and tracking.
- Always test the script manually before relying on the cron job to confirm it works correctly.