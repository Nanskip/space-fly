
-- This is tick function, executes every tick.
if gameOn then
    globalTimer = globalTimer + 1

    if globalTimer >= 60*enemyCount*10 then
        enemyCount = math.random(1, 3) + math.floor(roundCount*math.random(0, 10)*0.1)
        roundCount = roundCount + 1
        randScaleMultiplier = randScaleMultiplier + 0.01 * math.random(0, 2)
        randHealthMultiplier = randHealthMultiplier + math.random(0, 2) * math.ceil(roundCount*0.3)
        enemies.spawn(enemyCount)
        globalTimer = 0
    end
end