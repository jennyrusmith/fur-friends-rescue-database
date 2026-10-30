USE fur_friends_rescue;

-- 1. Turn off foreign key safety checks temporarily
SET FOREIGN_KEY_CHECKS = 0;

-- 2. Clean out the table completely
TRUNCATE TABLE placement;

-- 3. Turn the safety checks right back on
SET FOREIGN_KEY_CHECKS = 1;
