#!/usr/local/openresty/bin/resty

-- Copyright (c) 2019 Chrono

-- createdb -U postgres xxx
-- psql -U postgres
-- list db: \l
-- select db: \c postgres
-- show tables: \d

local cjson = require "cjson.safe"
local pgmoon = require "pgmoon"

local quote_sql_str = ngx.quote_sql_str

local db_params = {
    host = "127.0.0.1",
    port = "5432",
    database = "postgres",
    user = "postgres",
    password = "postgres",
}

-- return nil if failed
local function query_db(query)

    local pg = pgmoon.new(db_params)

    local ok, err = pg:connect()

    if not ok then
        ngx.log(ngx.ERR, "failed to connect to database: ", err)
        return
    end

    local res, err = pg:query(query)

    if not res then
        ngx.log(ngx.ERR, "failed to send query \"", query, "\": ", err)
        return
    end

    local ok, err = pg:keepalive()

    if not ok then
        ngx.log(ngx.ERR, "failed to keep alive: ", err)
        return
    end

    return res
end

local sql_create_table = [[
create table test (id int, name text);
]]

local sql_drop_table = [[
drop table if exists test;
]]

local sql_insert_table = [[
insert into test (id, name)
values(100, 'aaa');
]]

local sql_query_table = [[
select * from test;
]]

local res

res = query_db(sql_drop_table)
assert(res == true)

res = query_db(sql_create_table)
--print(res)
assert(res == true)

-- insert one row
res = query_db(sql_insert_table)
assert(res.affected_rows == 1)
print(cjson.encode(res))

-- return array of rows
res = query_db(sql_query_table)
assert(res[1].id == 100)
assert(res[1].name == 'aaa')

print(cjson.encode(res))

