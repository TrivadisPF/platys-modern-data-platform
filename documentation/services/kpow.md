# kpow

Kpow is the toolkit that empowers your team to deliver with Kafka.

Once installed, Kpow gathers information about your Kafka resources every minute, stores the results locally in internal topics, then provides custom telemetry and insights to you in a rich data-oriented UI.

**[Website](https://kpow.io/)** | **[Documentation](https://docs.kpow.io/)** | **[GitHub](https://github.com/factorhouse/kpow)**

```
platys init --enable-services KAFKA,KPOW
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28283>.

You have to get a license from [kpow](https://kpow.io/) here: <https://kpow.io/pricing/>.

Either add the license details to `config.yml` (if `KPOW_use_external_license_info` is set to `false`)

```yaml
      KPOW_use_external_license_info: false
      KPOW_license_id:
      KPOW_license_code: 
      KPOW_licensee:
      KPOW_license_expiry:
      KPOW_license_signature:  

```

or add it to `./licenses/kpow/kpow-license.env` if `KPOW_use_external_license_info` is set to `true`

```
## Your license details.
LICENSE_ID=xxxxxxx
LICENSE_CODE=TRIAL_30D
LICENSEE=yyyyy
LICENSE_EXPIRY=yyyy-mm-dd
LICENSE_SIGNATURE=zzzzzzzzzzzzzzzzzzz
```