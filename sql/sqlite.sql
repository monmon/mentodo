CREATE TABLE IF NOT EXISTS sessions (
    id           CHAR(72) PRIMARY KEY,
    session_data TEXT
);
CREATE TABLE IF NOT EXISTS entries (
    id       INTEGER PRIMARY KEY,
    body     TEXT NOT NULL,
    deadline DATETIME NOT NULL,
    priority INTEGER DEFAULT 0,
    is_done  TINYINT(1) DEFAULT 0
);
