local t = {}
local body
local shape
local material
local polygonsVerts {% for body in bodies %}
body = cc.PhysicsBody:create()
body:setDynamic({% if body.dynamic %} true {% else %} false {% endif %})
body:setEnable({% if body.enable %} true {% else %} false {% endif %})  {% for fixture in body.fixtures %}
material = cc.PhysicsMaterial({{fixture.density}}, {{fixture.restitution}}, {{fixture.friction}})  {% if fixture.isCircle %}
shape = cc.PhysicsShapeCircle.create({{fixture.radius}}, material, cc.p({{fixture.center.x}}, {{fixture.center.y}})) {% else %}
polygonsVerts = { {% for polygon in fixture.polygons %}
    { {% for point in polygon %}
        cc.p({{point.x}}, {{point.y}}){% if not forloop.last %},{% endif %}{% endfor %}
    }{% if not forloop.last %},{% endif %}{% endfor %}
   }
shape = cc.PhysicsShapePolygon:create(polygonsVerts, material) {% endif %}
shape:setGroup({{fixture.group}})   
shape:setCategoryBitmask({{fixture.categoryBitmask}})
shape:setCollisionBitmask({{fixture.collisionBitmask}})
shape:setContactTestBitmask({{fixture.contactTestBitmask}})
body:addShape(shape){% endfor %}
m["{{body.name}}"] = body{% endfor %}
return t