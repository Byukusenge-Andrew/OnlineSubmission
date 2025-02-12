-- Update existing assignments to set owner_id same as teacher_id
UPDATE Assignment SET owner_id = teacher_id WHERE owner_id IS NULL; 