Fiber = require 'fibers'

Nodes = ->
  nodes = (t) ->
    if t.left or t.right # If branch
      nodes t.left
      nodes t.right
    else # Leaf
      Fiber.yield t
  fiber = Fiber nodes
  fiber.run.bind fiber

t1 =
  left: 1
  right:
    left: 2
    right: 3
t2 =
  left:
    left: 1
    right: 2
  right: 3

nodes1 = Nodes()
nodes2 = Nodes()
l1 = nodes1 t1
l2 = nodes2 t2
loop
  console.log l1, l2
  throw Error "Different" if l1 isnt l2
  process.exit(0) unless l1
  l1 = nodes1()
  l2 = nodes2()
