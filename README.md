![Privacy Please](https://user-images.githubusercontent.com/133809/113155154-98193e80-91ed-11eb-9ff8-296e91c5e49c.png)

A proxy to enable privacy and TLS for images on the web.

Privacy Please uses the same URL structure and signature method as [camo](https://github.com/atmos/camo) so it can work as a drop-in replacement.

## Requirements

- Ruby 2.7

## Installation

```
git clone https://github.com/feedbin/privacy-please.git
cd privacy-please
bundle install
PRIVACY_KEY=secret bundle exec foreman start
```

## Configuration

Configuration is available through environment variables.

- `PRIVACY_KEY` The encryption key used to sign URLs

Optional variables

- `RACK_ENV` `development` (default) or `production`
- `PORT` which port to run on
- `MAX_THREADS` puma tuning
- `WEB_CONCURRENCY` puma tuning

## Usage

Replace `img[src]`, `video[poster]` etc… with the proxied url

```ruby
ENV["PRIVACY_KEY"] = "secret"

image_url = "http://example.com/image.jpg"
signature = OpenSSL::HMAC.hexdigest("sha1", ENV["PRIVACY_KEY"], image_url)
hex_url = image_url.to_enum(:each_byte).map { |byte| "%02x" % byte }.join

# The proxied image will be available here:
"http://localhost:5000/#{signature}/#{hex_url}"
```
