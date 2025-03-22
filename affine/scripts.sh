## Override the member-limit of 3 for free-plan:

```sh
docker exec -ti affine_postgres psql -U affine

```

## Override the member-limit of 3 for all users:

```sql
UPDATE features 
SET configs = jsonb_set(configs::jsonb, '{memberLimit}', '10')
WHERE configs::jsonb ? 'memberLimit';
```

## Override the document history-period to 365 days for all plans

```sql
UPDATE features
SET configs = jsonb_set(configs::jsonb, '{historyPeriod}', '31536000000')
WHERE configs::jsonb ? 'historyPeriod';
```