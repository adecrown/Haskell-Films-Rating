-- 
-- MATHFUN
-- Functional Programming Assignment 
-- UP720163
--
import Data.List
import Text.Printf
import Data.Maybe
import Data.Ord
import Data.Char
import Numeric
import System.IO
--
-- Types
type Title = String
type Director = String
type Year = Int
type Users = (String,Int)
--
-- Define Film type here 
data Film = Film Title Director Year [Users]
     deriving (Show,Read)

testDatabase ::[Film]
testDatabase = [Film "Blade Runner" "Ridley Scott" 1982 [("Amy",5), ("Bill",8), ("Ian",7), ("Kevin",9), ("Emma",4), ("Sam",7), ("Megan",4)],Film "The Fly" "David Cronenberg" 1986 [("Megan",4), ("Fred",7), ("Chris",5), ("Ian",0), ("Amy",6)],Film "Psycho" "Alfred Hitchcock" 1960 [("Bill",4), ("Jo",4), ("Garry",8), ("Kevin",7), ("Olga",8), ("Liz",10), ("Ian",9)],Film "Body Of Lies" "Ridley Scott" 2008 [("Sam",3), ("Neal",7), ("Kevin",2), ("Chris",5), ("Olga",6)],Film "Avatar" "James Cameron" 2009 [("Olga",1), ("Wally",8), ("Megan",9), ("Tim",5), ("Zoe",8), ("Emma",3)],Film "Titanic" "James Cameron" 1997 [("Zoe",7), ("Amy",1), ("Emma",5), ("Heidi",3), ("Jo",8), ("Megan",5), ("Olga",7), ("Tim",10)],Film "The Departed" "Martin Scorsese" 2006 [("Heidi",3), ("Jo",8), ("Megan",5), ("Tim",3), ("Fred",5)],Film "Aliens" "Ridley Scott" 1986 [("Fred",9), ("Dave",6), ("Amy",10), ("Bill",7), ("Wally",1), ("Zoe",5)],Film "Kingdom Of Heaven" "Ridley Scott" 2005 [("Garry",3), ("Chris",7), ("Emma",5), ("Bill",1), ("Dave",3)],Film "E.T. The Extra-Terrestrial" "Steven Spielberg" 1982 [("Ian",9), ("Amy",1), ("Emma",7), ("Sam",8), ("Wally",5), ("Zoe",6)],Film "Bridge of Spies" "Steven Spielberg" 2015 [("Fred",3), ("Garry",4), ("Amy",10), ("Bill",7), ("Wally",6)],Film "Vertigo" "Alfred Hitchcock" 1958 [("Bill",8), ("Emma",5), ("Garry",1), ("Kevin",6), ("Olga",6), ("Tim",10)],Film "The Birds" "Alfred Hitchcock" 1963 [("Garry",7), ("Kevin",8), ("Olga",4), ("Tim",8), ("Wally",3)],Film "Jaws" "Steven Spielberg" 1975 [("Fred",3), ("Garry",0), ("Jo",3), ("Neal",9), ("Emma",7)],Film "The Martian" "Ridley Scott" 2015 [("Emma",7), ("Sam",8), ("Wally",5), ("Dave",10)],Film "The Shawshank Redemption" "Frank Darabont" 1994 [("Jo",8), ("Sam",10), ("Zoe",4), ("Dave",7), ("Emma",3), ("Garry",10), ("Kevin",7)], Film "Gladiator" "Ridley Scott" 2000 [("Garry",7), ("Ian",4), ("Neal",5), ("Wally",3), ("Emma",4)],Film "The Green Mile" "Frank Darabont" 1999 [("Sam",3), ("Zoe",4), ("Dave",7), ("Wally",5), ("Jo",5)],Film "True Lies" "James Cameron" 1994 [("Dave",3), ("Kevin",10), ("Jo",0)],Film "Super 8" "J J Abrams" 2011 [("Dave",7), ("Wally",3), ("Garry",5), ("Megan",4)],Film "Minority Report" "Steven Spielberg" 2002 [("Dave",6), ("Garry",6), ("Megan",2), ("Sam",7), ("Wally",8)],Film "War Horse" "Steven Spielberg" 2011 [("Dave",6), ("Garry",6), ("Megan",3), ("Sam",7), ("Wally",8), ("Zoe",8)],Film "The Terminal" "Steven Spielberg" 2004 [("Olga",8), ("Heidi",8), ("Bill",2), ("Sam",6), ("Garry",8)],Film "Star Wars: The Force Awakens" "J J Abrams" 2015 [("Olga",6), ("Zoe",6), ("Bill",9), ("Sam",7), ("Wally",8), ("Emma",8)],Film "Hugo" "Martin Scorsese" 2011 [("Sam",9), ("Wally",3), ("Zoe",5), ("Liz",7)]]

-- 
--
--  Your functional code goes here

-- this gets the ratings of films and output them in a list
movieWebRatings :: [(String,Int)]  -> [Int]
movieWebRatings pairList = [ j | (l,j) <- pairList ]

-- this gets a list of ratings and then outputs their avarage
movieRatingsPair :: [Int] -> Float
movieRatingsPair [] = 0.0
movieRatingsPair (x:xs)
        | length (x:xs) == 1 = fromIntegral (x)
        | otherwise = fromIntegral (sum (x:xs)) / fromIntegral (length (x:xs))
        

-- this just calls both movieWebRatings and movieRatingsPair
joinRatings :: [(String,Int)] -> Float
joinRatings [] = 0
joinRatings ((x,y):xs) = (movieRatingsPair (movieWebRatings ((x,y):xs)))


-- this turns a list of tuples into string
movieRatings :: [(String,Int)] -> String
movieRatings [] = ""
movieRatings ((x,y):xs)
        | length (((x,y):xs)) == 1 = x ++ ": " ++ show y
        | otherwise = x ++ ": " ++ show y ++ ", " ++ movieRatings xs
        
        
addFilm :: [Film] -> Film -> [Film]
addFilm existingFilms newFilm = existingFilms ++ [newFilm]

filmsAsString :: [Film] -> String
filmsAsString [] = ""
filmsAsString ((Film title director year users) : films) = title ++ " (" ++ show year ++ ")\n" ++ showDirector director  ++  showWebRating users ++ showUsers users ++ filmsAsString films
    where
        showDirector director = "Director: " ++ director ++ "\n"
        showWebRating users = "Website Rating: " ++ show(showGFloat (Just 2) (joinRatings users) "") ++ "\n"
        showUsers users = "Users Rating: " ++ movieRatings users ++ "\n\n"
        

-- filters out movie of a given director
filmsByDirector :: [Film] -> String -> [Film]
filmsByDirector films dirt = filter (\(Film title director year users) -> dirt==director) films

websiteRating7 :: [Film] -> [Film]
websiteRating7 films = filter (\(Film title director year users) -> joinRatings users >= 7) films


averageDirectorFilm  :: [Film] -> String -> [(String,Int)]
averageDirectorFilm  [] _ = []
averageDirectorFilm  films dirt = average [users | (Film title director year users) <- films, dirt==director] 
    where average (x:xs) 
                  |length (x:xs) == 1 = x
                  |length (x:xs) > 1 = x ++ average xs 
                  |otherwise = []

averageDirector = averageDirectorFilm testDatabase "Ridley Scott"
averageDirectorNum = joinRatings averageDirector
        

-- collects user tuple list and username to checks if a user has rated a film
usersRating :: [Users] -> String -> Bool
usersRating xs username = maybe False (> 0) (lookup username xs)


-- collects username and film list to checks if a user has rated a film 
hasUserRatedFilm :: String -> Film -> Bool
hasUserRatedFilm username (Film title director year users) = usersRating users username


-- Returns all the films the user has rated
ratedFilms :: String -> [Film] -> [Film]
ratedFilms username films = filter (hasUserRatedFilm username) films


-- Return the user ratings. Returns 0 if none are found
ratedFilmsMarks :: String -> Film -> Int
ratedFilmsMarks username (Film title director year users) = maybe 0 id (lookup username users)


-- returns an output of films and ratings the user gave
whatUserRated :: String -> [Film] -> IO ()
whatUserRated username films = mapM_ (putStrLn . showResult) $ ratedFilms username films
  where
    showResult film@(Film title director year users) = "Title: " ++ title ++ "\n" ++ "Rating: " ++
      show (ratedFilmsMarks username film) ++ "\n"


-- checks if users has rated a film before, if so, change the rating, if not, add the rating
addRating :: [Users] -> Users -> [Users]
addRating [] rating = rating:[] 
addRating ((user, rating):xs) (newUser, newRating)
                    |newUser == user = ((newUser, newRating):xs)
                    |otherwise = (user, rating) : (addRating xs (newUser, newRating))
 


-- checkes if the film title given exit, if so it calls the addRating function to change the rating
rateFilm :: (String,Int) -> String -> [Film] -> [Film]
rateFilm _ _ [] = []
rateFilm userrating filmtitle ((Film title director year users):films)
    | filmtitle == title = (Film title director year (addRating users userrating)) : (rateFilm userrating filmtitle films)
    | otherwise = (Film title director year users) : (rateFilm userrating filmtitle films)


-- this sorts the film in descending order
sortFilms :: [Film] -> [Film]
sortFilms = sortBy $ flip $ comparing joinRatings'
  where
    joinRatings' (Film title director year users) = joinRatings users

-- filters out films released within a given year                
filmsReleased :: [Film] -> Int -> Int -> [Film]            
filmsReleased films min max =  sortFilms $ filter (\(Film title director year users) -> (min <= year && year <= max) ) films

putStringOut :: [Film] -> String -> String
putStringOut film text = text

capWord [] = []
capWord (h:t) = toUpper h : map toLower t



-- Demo function to test basic functionality (without persistence - i.e. 
-- testDatabase doesn't change and nothing is saved/loaded to/from file).

demo :: Int -> IO ()
demo 1  = putStrLn $ filmsAsString $ addFilm testDatabase (Film "The BFG" "Steven Spielberg" 2016 [] )
demo 2  = putStrLn $ filmsAsString testDatabase
demo 3  = putStrLn $ filmsAsString  $ filmsByDirector testDatabase "Ridley Scott"
demo 4  = putStrLn $ filmsAsString  $ websiteRating7 testDatabase
demo 5  = putStrLn $  show (joinRatings (averageDirectorFilm testDatabase "Ridley Scott"))
demo 6  = whatUserRated "Emma" testDatabase
demo 7  = putStrLn $ filmsAsString (rateFilm ("Emma",10) "Hugo" testDatabase)
demo 77 = putStrLn $ filmsAsString (rateFilm ("Emma",10) "Avatar" testDatabase)
demo 8  = putStrLn $ filmsAsString  $ filmsReleased testDatabase 2010 2014



--
--
-- Your user interface code goes here

getString :: String -> IO String
getString prompt = do
    putStrLn prompt
    getLine


getInt :: String -> IO Int
getInt prompt = do 
    putStrLn prompt
    str <- getLine
    return (read str :: Int)


startMenu :: IO ()
startMenu = do
    usernameS <- getString "Please enter your username: "
    if usernameS == ""
    then do
    putStrLn "You need to type in your username."
    startMenu
    else do
    let username = capWord usernameS
    content <- readFile "films.txt"
    let filmList = read content :: [Film]
    finalFilmList <- menu filmList username
    writeFile "films.txt" $ show finalFilmList
    putStrLn "File saved"

menu :: [Film] -> String -> IO [Film]
menu filmList username = do
    putStrLn  "                              --#--#--#--#--#--#--"
    putStrLn ("                              --#  Hello " ++ username ++ "!  #--")
    putStrLn "--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--\n--#\n--#  MAIN MENU\n--#   .Type any of the numbers below to begin\n--#   .Type anything else to quit\n--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--"
    putStrLn "\n---------------------------------------------------------------------------\n--1. Add a new film to the database.\n--2. Give all films in the database.\n--3. Give all films by a given director.\n--4. Give all films that have a website rating of 7 or higher.\n--5. Give the average website rating for the films of a given director.\n--6. Give the titles of the films a given user has rated, along with that user’s ratings.\n--7. Allow a given user to rate (or re-rate) a film.\n--8. Give all the films released between two given years (inclusive), sorted in descending order of website rating.\n----------------------------------------------------------------------------------\n"
    choice <- getLine
    case choice of
        "1" -> do
            title <- getString "Please enter film title: "
            if title == ""
            then do 
            putStrLn "You didn't enter a film title"
            menu filmList username
            else do
            director <- getString "Please enter film director: " 
            if  director == ""
            then do 
            putStrLn "You didn't enter the film director"
            menu filmList username
            else do
            year <- getInt "Please enter film year: "
            putStrLn ""
            putStrLn "We've added your film"
            let newList = addFilm filmList (Film title director year [])
            menu newList username
            
           

        "2" -> do
            putStrLn $ filmsAsString filmList
            menu filmList username

        "3" -> do
            director <- getString "Please enter Directors Name: "
            putStrLn ""
            putStrLn ("These are the films directed by "++director++": \n")
            putStrLn $ filmsAsString  $ filmsByDirector filmList director
            menu filmList username

        "4" -> do
            putStrLn ""
            putStrLn ("Films with a website rating of 7 or higher: \n")
            putStrLn $ filmsAsString  $ websiteRating7 filmList
            menu filmList username
            
        "5" -> do
            director <- getString "Please enter Directors Name: "
            putStrLn ""
            printf "%3.2f Director's average" $ joinRatings (averageDirectorFilm testDatabase director)
            putStrLn ""
            menu filmList username
            
        "6" -> do
            putStrLn ""
            putStrLn ("Films you have rated: \n")
            whatUserRated username filmList
            menu filmList username
            
        "7" -> do
            title <- getString "Please enter film title: "
            if title == ""
            then do 
            putStrLn "You didn't enter a film title"
            menu filmList username
            else do
            rating <- getInt "Please enter your new rating: "
            let rated = rateFilm (username,rating) title filmList
            putStrLn $ filmsAsString rated
            putStrLn ""
            putStrLn ("Rating accepted")
            menu rated username
            
        "8" -> do
            year1 <- getInt "Please enter the first year: "
            year2 <- getInt "Please enter the second year: " 
            let result = filmsAsString  $ filmsReleased filmList year1 year2
            if result == []
            then do
            putStrLn "There are no films within this years"
            menu filmList username
            else do
            putStrLn ""
            putStrLn ("Films released between "++show year1++" and "++show year2++"\n")
            putStrLn $ result
            menu filmList username
        _   -> do
              putStrLn "-----------------------------------------------------------------------------\n--\n--\n--                  BYE BYE\n--\n-----------------------------------------------------------------------------"
              return filmList