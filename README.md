# Joshua Merrell - Professional Website

Job profile site for Joshua Merrell, featuring consulting services and project portfolio.

## Local Development

Start a local server:
```bash
python3 -m http.server 8000
```

Visit: http://localhost:8000

## GitHub Pages Deployment

The site auto-deploys to GitHub Pages on pushes to `master` branch via GitHub Actions.

## DNS Migration from AWS

To migrate the domain from AWS to GitHub Pages:

1. **Update DNS Records in Route53 (or current DNS provider):**
   - Change the `A` record for `jbm.eco` to GitHub Pages IPs:
     - `185.199.108.153`
     - `185.199.109.153`
     - `185.199.110.153`
     - `185.199.111.153`
   - Or add a `CNAME` record pointing to `brantmerrell.github.io`

2. **Configure GitHub Pages:**
   - In repository settings → Pages
   - Set source to "Deploy from a branch"
   - Select `master` branch
   - Add custom domain: `jbm.eco`

3. **Enable HTTPS:**
   - Check "Enforce HTTPS" in GitHub Pages settings
   - Wait for SSL certificate provisioning

4. **Cleanup AWS Resources:**
   - Remove S3 bucket: `s3://jbm.eco/`
   - Remove any CloudFront distributions
   - Keep Route53 hosted zone if managing DNS there

## Previous Content

The original chess-focused content has been moved to `../my-chess/` and preserved the markdown files for future use.