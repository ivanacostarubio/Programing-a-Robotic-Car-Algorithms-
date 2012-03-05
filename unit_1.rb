
#
# CS 373
#

@p=[0.2, 0.2, 0.2, 0.2, 0.2]
@world=['green', 'red', 'red', 'green', 'green']
@measurements = ['red', 'red']
@motions = [1,1]
@pHit = 0.6
@pMiss = 0.2
@pExact = 0.8
@pOvershoot = 0.1
@pUndershoot = 0.1

def sense(p, z)
  q=[]
  p.size.times do |i| 
    hit = (z == @world[i])
    if hit == false
      hit = 0
    else
      hit = 1
    end
    q << (p[i] * (hit * @pHit + (1-hit) * @pMiss))

    @s = q.inject{|sum, qq| sum += qq}

  end

  q.size.times do |rr|
      q[rr] = q[rr] / @s
  end


  return q
end

def move(p, u)
  q = []
  p.size.times do |i|
    s = @pExact * p[(i-u) % p.size]
    s = s + @pOvershoot * p[(i-u-1) % p.size]
    s = s + @pUndershoot * p[(i-u+1) % p.size]
    q << s
  end
  return q
end

@measurements.size.times do |k|
  @p = sense(@p, @measurements[k])
  @p = move(@p, @motions[k])
end

puts @p.inspect
