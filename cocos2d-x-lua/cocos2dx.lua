-- Generate by Physics Editor Don't edit it --

return {
    m2pRatio = {{global.m2pRatio|floatformat}},
    gravity = {{global.gravity|floatformat}},
    bodys = {{% for body in bodies %}
        {{body.name}} = {  
            dynamic = {% if body.dynamic %}true{% else %}false{% endif %},
            enable = {% if body.enable %}true{% else %}false{% endif %},
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
                    radius = {{fixture.radius|floatformat}},
                    offset = {
                        x = {{fixture.center.x|floatformat}} - {{body.size.width|floatformat}} / 2,
                        y = {{fixture.center.y|floatformat}} - {{body.size.height|floatformat}} / 2
                    },{% else %}
                    isCircle = false,
                    polygonsVerts = {{% for polygon in fixture.polygons %}
                        {{% for point in polygon %}
                            cc.p({{point.x|floatformat}}, {{point.y|floatformat}}){% if not forloop.last %},{% endif %}{% endfor %}
                        }{% if not forloop.last %},{% endif %}{% endfor %}
                    }{% endif %}
                }{% if not forloop.last %},{% endif %}{% endfor %}
            }
        }{% if not forloop.last %},{% endif %}{% endfor %}
    }
}
