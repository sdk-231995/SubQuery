create database spotify;
use spotify;

-- 1
CREATE TABLE Musicians (
    Musician_ID INT PRIMARY KEY,
    Name_Last VARCHAR(100),
    Name_First VARCHAR(100),
    Birthdate DATE,
    Birthplace VARCHAR(100)
);

-- 2
CREATE TABLE Artists (
    Artist_ID INT PRIMARY KEY,
    Name VARCHAR(100)
);
-- 3
CREATE TABLE Group_Members (
    Musician_ID INT,
    Artist_ID INT,
    PRIMARY KEY (Musician_ID, Artist_ID),
    FOREIGN KEY (Musician_ID) REFERENCES Musicians(Musician_ID),
    FOREIGN KEY (Artist_ID) REFERENCES Artists(Artist_ID)
);
-- 4
CREATE TABLE Labels (
    Label_ID INT PRIMARY KEY,
    Name VARCHAR(100)
);

-- 5
CREATE TABLE Albums (
    Album_ID INT PRIMARY KEY,
    Title VARCHAR(100),
    Artist_ID INT,
    Year INT,
    Label_ID INT,
    FOREIGN KEY (Artist_ID) REFERENCES Artists(Artist_ID),
    FOREIGN KEY (Label_ID) REFERENCES Labels(Label_ID)
);

--  6

CREATE TABLE Genres (
    Genre_ID INT PRIMARY KEY,
    Name VARCHAR(100)
);


-- 7
CREATE TABLE Tracks (
    Album_ID INT,
    Track_Num INT,
    Title VARCHAR(100),
    Genre_ID INT,
    Length INT,
    PRIMARY KEY (Album_ID, Track_Num),
    FOREIGN KEY (Album_ID) REFERENCES Albums(Album_ID),
    FOREIGN KEY (Genre_ID) REFERENCES Genres(Genre_ID)
);

-- 8

CREATE TABLE Reviewers (
    Reviewer_ID INT PRIMARY KEY,
    Joined DATE
);

-- 9
CREATE TABLE Album_Reviews (
    Reviewer_ID INT,
    Album_ID INT,
    Ranking INT,
    Comment TEXT,
    PRIMARY KEY (Reviewer_ID, Album_ID),
    FOREIGN KEY (Reviewer_ID) REFERENCES Reviewers(Reviewer_ID),
    FOREIGN KEY (Album_ID) REFERENCES Albums(Album_ID)
);

-- 10
CREATE TABLE Track_Reviews (
    Reviewer_ID INT,
    Album_ID INT,
    Track_Num INT,
    Ranking INT,
    Comment TEXT,
    PRIMARY KEY (Reviewer_ID, Album_ID, Track_Num),
    FOREIGN KEY (Reviewer_ID) REFERENCES Reviewers(Reviewer_ID),
    FOREIGN KEY (Album_ID, Track_Num) REFERENCES Tracks(Album_ID, Track_Num)
);

INSERT INTO Musicians VALUES
(1, 'Smith', 'John', '1978-03-14', 'New York'),
(2, 'Doe', 'Jane', '1985-11-22', 'Los Angeles'),
(3, 'Lee', 'Kevin', '1990-05-30', 'Chicago'),
(4, 'Brown', 'Emily', '1975-02-10', 'Houston'),
(5, 'Taylor', 'Michael', '1982-09-18', 'Phoenix'),
(6, 'Wilson', 'Laura', '1991-04-09', 'Philadelphia'),
(7, 'Clark', 'Brian', '1968-12-06', 'San Diego'),
(8, 'Hall', 'Anna', '1989-08-25', 'Dallas'),
(9, 'Allen', 'Chris', '1979-10-03', 'San Jose'),
(10, 'Young', 'Amy', '1986-07-19', 'Austin'),
(11, 'King', 'David', '1992-01-14', 'Jacksonville'),
(12, 'Scott', 'Sophia', '1988-06-11', 'Fort Worth'),
(13, 'Green', 'Daniel', '1973-04-22', 'Columbus'),
(14, 'Adams', 'Olivia', '1980-03-17', 'Charlotte'),
(15, 'Baker', 'James', '1993-09-12', 'San Francisco');

INSERT INTO Artists VALUES
(1, 'Artist_1'),
(2, 'Artist_2'),
(3, 'Artist_3'),
(4, 'Artist_4'),
(5, 'Artist_5'),
(6, 'Artist_6'),
(7, 'Artist_7'),
(8, 'Artist_8'),
(9, 'Artist_9'),
(10, 'Artist_10'),
(11, 'Artist_11'),
(12, 'Artist_12'),
(13, 'Artist_13'),
(14, 'Artist_14'),
(15, 'Artist_15');
INSERT INTO Group_Members VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15);

INSERT INTO Labels VALUES
(1, 'Label_1'),
(2, 'Label_2'),
(3, 'Label_3'),
(4, 'Label_4'),
(5, 'Label_5'),
(6, 'Label_6'),
(7, 'Label_7'),
(8, 'Label_8'),
(9, 'Label_9'),
(10, 'Label_10'),
(11, 'Label_11'),
(12, 'Label_12'),
(13, 'Label_13'),
(14, 'Label_14'),
(15, 'Label_15');
INSERT INTO Albums VALUES
(1, 'Album_1', 1, 2005, 1),
(2, 'Album_2', 2, 2006, 2),
(3, 'Album_3', 3, 2007, 3),
(4, 'Album_4', 4, 2008, 4),
(5, 'Album_5', 5, 2009, 5),
(6, 'Album_6', 6, 2010, 6),
(7, 'Album_7', 7, 2011, 7),
(8, 'Album_8', 8, 2012, 8),
(9, 'Album_9', 9, 2013, 9),
(10, 'Album_10', 10, 2014, 10),
(11, 'Album_11', 11, 2015, 11),
(12, 'Album_12', 12, 2016, 12),
(13, 'Album_13', 13, 2017, 13),
(14, 'Album_14', 14, 2018, 14),
(15, 'Album_15', 15, 2019, 15);
INSERT INTO Genres VALUES
(1, 'Genre_1'),
(2, 'Genre_2'),
(3, 'Genre_3'),
(4, 'Genre_4'),
(5, 'Genre_5'),
(6, 'Genre_6'),
(7, 'Genre_7'),
(8, 'Genre_8'),
(9, 'Genre_9'),
(10, 'Genre_10'),
(11, 'Genre_11'),
(12, 'Genre_12'),
(13, 'Genre_13'),
(14, 'Genre_14'),
(15, 'Genre_15');
INSERT INTO Tracks VALUES
(1, 1, 'Track_1', 1, 240),
(2, 2, 'Track_2', 2, 260),
(3, 3, 'Track_3', 3, 210),
(4, 4, 'Track_4', 4, 300),
(5, 5, 'Track_5', 5, 180),
(6, 6, 'Track_6', 6, 270),
(7, 7, 'Track_7', 7, 150),
(8, 8, 'Track_8', 8, 320),
(9, 9, 'Track_9', 9, 205),
(10, 10, 'Track_10', 10, 275),
(11, 11, 'Track_11', 11, 260),
(12, 12, 'Track_12', 12, 190),
(13, 13, 'Track_13', 13, 240),
(14, 14, 'Track_14', 14, 225),
(15, 15, 'Track_15', 15, 310);
INSERT INTO Reviewers VALUES
(1, '2015-06-10'),
(2, '2014-09-22'),
(3, '2016-11-12'),
(4, '2017-03-15'),
(5, '2018-01-05'),
(6, '2019-07-08'),
(7, '2020-10-20'),
(8, '2021-04-11'),
(9, '2022-02-17'),
(10, '2023-06-25'),
(11, '2013-08-09'),
(12, '2012-12-30'),
(13, '2010-05-15'),
(14, '2009-09-14'),
(15, '2008-11-03');
INSERT INTO Album_Reviews VALUES
(1, 1, 8, 'Amazing vocals and depth'),
(2, 2, 7, 'Solid tracks, very enjoyable'),
(3, 3, 9, 'Classic album, timeless'),
(4, 4, 6, 'Somewhat average songs'),
(5, 5, 10, 'Perfect collection'),
(6, 6, 7, 'Nice vibe overall'),
(7, 7, 8, 'Loved the transitions'),
(8, 8, 6, 'Could use more energy'),
(9, 9, 9, 'Brilliant composition'),
(10, 10, 7, 'Funky and fresh'),
(11, 11, 10, 'A masterpiece'),
(12, 12, 9, 'Beautiful melodies'),
(13, 13, 8, 'Very rhythmic'),
(14, 14, 7, 'Balanced and clean'),
(15, 15, 6, 'Mediocre experience');
INSERT INTO Track_Reviews VALUES
(1, 1, 1, 8, 'Energetic start to album'),
(2, 2, 2, 7, 'Smooth vocals'),
(3, 3, 3, 9, 'Bassline is amazing'),
(4, 4, 4, 6, 'Okay beat'),
(5, 5, 5, 10, 'Top-notch groove'),
(6, 6, 6, 7, 'Catchy lyrics'),
(7, 7, 7, 8, 'Really fun'),
(8, 8, 8, 6, 'Could be better'),
(9, 9, 9, 9, 'Loved it'),
(10, 10, 10, 7, 'Good enough'),
(11, 11, 11, 10, 'Fantastic solo'),
(12, 12, 12, 9, 'Loved the rhythm'),
(13, 13, 13, 8, 'Nice drum work'),
(14, 14, 14, 7, 'Not bad'),
(15, 15, 15, 6, 'Average ending');
