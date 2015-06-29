API Design
==========

Log In
------
POST /api/login
username=juan
password=secret38

Response:
```json
{
  token: 'Abc123',
}
```

Log Out
-------
GET /api/logout

Get all daily logs
------------------
Default: last 30 symbols past 30 days
GET /api/daily

Get daily logs for specified symbols
------------------------------------
Default: past 30 days
GET /api/daily/ABC,AYA,XXX
GET /api/daily/ABC # just ABCs

Get daily logs for specified symbol by date range
-------------------------------------------------
GET /api/daily/ABC?from=ISODATE&to=ISODATE

