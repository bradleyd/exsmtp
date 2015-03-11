Exsmtp
======

Basic SMTP server for Elixir. 
It uses the wonderful [gen_smtp](https://github.com/Vagabond/gen_smtp)

There was also code inspired by [HashNuke's Mail To JSON](https://github.com/HashNuke/mail-to-json)


## Usage

Include into `mix.exs`

Set the SMTP port either in the config or by environment variable `EXSMTP_SMTP_PORT`

Start in foreground

```elxir
mix run --no-halt

17:00:26.314 [info]  :gen_smtp_server starting at :nonode@nohost

17:00:26.324 [info]  :gen_smtp_server listening on {0, 0, 0, 0}:2525 via :tcp
```

## TODO 
- [ ] Better tests
- [ ] Parse email so humans can use it
- [ ] Benchmark
- [ ] Scriptize?
