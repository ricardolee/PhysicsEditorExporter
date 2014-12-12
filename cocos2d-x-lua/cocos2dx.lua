-- Generate by Physics Editor Don't edit it --

return {
    m2pRatio = {{global.m2pRatio|floatformat}},
    gravity = {{global.gravity|floatformat}},
    bodys = {{% for body in bodies %}
        {{body.name}} = {  
            dynamic = {% if body.isDynamic %}true{% else %}false{% endif %},
            gravityDynamic = {% if body.isGravityDynamic %}true{% else %}false{% endif %},
            enable = {% if body.isEnable %}true{% else %}false{% endif %},
            fixtures = {{% for fixture in body.fixtures %}
                {
                    density = {{fixture.density|floatformat}},
                    restitution = {{fixture.restitution|floatformat}},
                    friction = {{fixture.friction|floatformat}},
                    group = {{fixture.group}},   
                    categoryBitmask = {{fixture.categoryBitmask}},
                    collisionBitmask = {{fixture.collisionBitmask}},
                    contactTestBitmask = {{fixture.contactTestBitmask}},{% if fixture.isCircle %}
                    isCircle = true,
                    radius = {{fixture.radius|floatformat}},{% else %}
                    isCircle = false,{% if fixture.isEdge %}
                    isEdge = true,
                    border = {{fixture.border|floatformat}},
                    hullVerts = {{%for point in fixture.hull %}
                        cc.p({{point.x|floatformat}}, {{point.y|floatformat}}){% if not forloop.last %},{% endif %}{% endfor %}
                    }{% else %}
                    isEdge = false,
                    polygonsVerts = {{% for polygon in fixture.polygons %}
                        {{% for point in polygon %}
                            cc.p({{point.x|floatformat}}, {{point.y|floatformat}}){% if not forloop.last %},{% endif %}{% endfor %}
                        }{% if not forloop.last %},{% endif %}{% endfor %}
                    }{% endif %}{% endif %}
                }{% if not forloop.last %},{% endif %}{% endfor %}
            }
        }{% if not forloop.last %},{% endif %}{% endfor %}
    }
}
