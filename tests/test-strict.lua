local strict = require 'pl.strict'
local test = require 'pl.test'
local app = require 'pl.app'

-- in strict mode, you must assign to a global first, even if just nil.
test.assertraise(function()
   print(x)
   print 'ok?'
end,"variable 'x' is not declared")

-- can assign to globals in main (or from C extensions) But not anywhere else!
Boo = true

--- a module may use strict.module() to generate a simularly strict environment
-- (see lua/mymod.lua)
app.require_here 'lua'
local M = require 'mymod'

--- these are fine
M.answer()
M.question()

-- spelling mistakes become errors...
test.assertraise(function()
    print(M.Answer())
end,"variable 'Answer' is not declared in 'mymod'")

--- for the extra paranoid, you can choose to make all global tables strict...
strict.make_all_strict(_G)

test.assertraise(function()
    print(math.sine(1.2))
end,"variable 'sine' is not declared in 'math'")









