-- Insert data into Users table
INSERT INTO Users (id, login, password) VALUES (1, 'john_doe', 'hashed_password_1');
INSERT INTO Users (id, login, password) VALUES (2, 'jane_smith', 'hashed_password_2');
INSERT INTO Users (id, login, password) VALUES (3, 'bob_johnson', 'hashed_password_3');
INSERT INTO Users (id, login, password) VALUES (4, 'sarah_wilson', 'hashed_password_4');
INSERT INTO Users (id, login, password) VALUES (5, 'mike_brown', 'hashed_password_5');
INSERT INTO Users (id, login, password) VALUES (6, 'alex_taylor', 'hashed_password_6');
INSERT INTO Users (id, login, password) VALUES (7, 'emma_garcia', 'hashed_password_7');
INSERT INTO Users (id, login, password) VALUES (8, 'david_miller', 'hashed_password_8');
COMMIT;


-- Insert data into Individuals table
INSERT INTO Individuals (id, name, info) VALUES (101, 'John Doe', 'Software Developer from New York');
INSERT INTO Individuals (id, name, info) VALUES (102, 'Jane Smith', 'Project Manager with 5 years experience');
INSERT INTO Individuals (id, name, info) VALUES (103, 'Robert Johnson', 'Database Administrator');
INSERT INTO Individuals (id, name, info) VALUES (104, 'Emily Davis', 'UI/UX Designer');
INSERT INTO Individuals (id, name, info) VALUES (105, 'Sarah Wilson', 'Backend Developer specializing in Java');
INSERT INTO Individuals (id, name, info) VALUES (106, 'Michael Brown', 'DevOps Engineer with cloud expertise');
INSERT INTO Individuals (id, name, info) VALUES (107, 'Alexandra Taylor', 'Technical Writer and QA Specialist');
INSERT INTO Individuals (id, name, info) VALUES (108, 'Emma Garcia', 'Full Stack Developer with React experience');
INSERT INTO Individuals (id, name, info) VALUES (109, 'David Miller', 'System Architect with 10 years experience');
INSERT INTO Individuals (id, name, info) VALUES (110, 'Jennifer Lewis', 'Data Scientist focusing on ML algorithms');
INSERT INTO Individuals (id, name, info) VALUES (111, 'Thomas Clark', 'Network Security Engineer');
COMMIT;

-- Insert data into Tasks table
INSERT INTO Tasks (id, description) VALUES (201, 'Implement user authentication module');
INSERT INTO Tasks (id, description) VALUES (202, 'Design database schema for new client project');
INSERT INTO Tasks (id, description) VALUES (203, 'Create wireframes for mobile application');
INSERT INTO Tasks (id, description) VALUES (204, 'Fix bug in reporting module');
INSERT INTO Tasks (id, description) VALUES (205, 'Prepare documentation for API endpoints');
INSERT INTO Tasks (id, description) VALUES (206, 'Optimize database queries for better performance');
INSERT INTO Tasks (id, description) VALUES (207, 'Configure continuous integration pipeline');
INSERT INTO Tasks (id, description) VALUES (208, 'Write user manual for new software release');
INSERT INTO Tasks (id, description) VALUES (209, 'Develop RESTful API endpoints for mobile app');
INSERT INTO Tasks (id, description) VALUES (210, 'Create system architecture diagram');
INSERT INTO Tasks (id, description) VALUES (211, 'Analyze customer data for purchase patterns');
INSERT INTO Tasks (id, description) VALUES (212, 'Conduct security audit of network infrastructure');
INSERT INTO Tasks (id, description) VALUES (213, 'Implement responsive design for website');
INSERT INTO Tasks (id, description) VALUES (214, 'Debug performance issues in production environment');
INSERT INTO Tasks (id, description) VALUES (215, 'Create automated test suite for core functionality');
COMMIT;
-- Insert data into User_Individual relationship table
INSERT INTO User_Individual (user_id, individual_id) VALUES (1, 101);
INSERT INTO User_Individual (user_id, individual_id) VALUES (1, 102);
INSERT INTO User_Individual (user_id, individual_id) VALUES (2, 102);
INSERT INTO User_Individual (user_id, individual_id) VALUES (2, 103);
INSERT INTO User_Individual (user_id, individual_id) VALUES (3, 104);
INSERT INTO User_Individual (user_id, individual_id) VALUES (1, 104);
INSERT INTO User_Individual (user_id, individual_id) VALUES (2, 105);
INSERT INTO User_Individual (user_id, individual_id) VALUES (3, 106);
INSERT INTO User_Individual (user_id, individual_id) VALUES (4, 107);
INSERT INTO User_Individual (user_id, individual_id) VALUES (4, 108);
INSERT INTO User_Individual (user_id, individual_id) VALUES (5, 109);
INSERT INTO User_Individual (user_id, individual_id) VALUES (5, 110);
INSERT INTO User_Individual (user_id, individual_id) VALUES (6, 111);
INSERT INTO User_Individual (user_id, individual_id) VALUES (6, 101);
INSERT INTO User_Individual (user_id, individual_id) VALUES (7, 102);
INSERT INTO User_Individual (user_id, individual_id) VALUES (7, 103);
INSERT INTO User_Individual (user_id, individual_id) VALUES (8, 104);
INSERT INTO User_Individual (user_id, individual_id) VALUES (8, 105);
COMMIT;

-- Insert data into User_Task relationship table
INSERT INTO User_Task (user_id, task_id) VALUES (1, 201);
INSERT INTO User_Task (user_id, task_id) VALUES (1, 204);
INSERT INTO User_Task (user_id, task_id) VALUES (2, 202);
INSERT INTO User_Task (user_id, task_id) VALUES (2, 205);
INSERT INTO User_Task (user_id, task_id) VALUES (3, 203);
INSERT INTO User_Task (user_id, task_id) VALUES (1, 206);
INSERT INTO User_Task (user_id, task_id) VALUES (2, 207);
INSERT INTO User_Task (user_id, task_id) VALUES (3, 208);
INSERT INTO User_Task (user_id, task_id) VALUES (4, 209);
INSERT INTO User_Task (user_id, task_id) VALUES (4, 213);
INSERT INTO User_Task (user_id, task_id) VALUES (5, 210);
INSERT INTO User_Task (user_id, task_id) VALUES (5, 214);
INSERT INTO User_Task (user_id, task_id) VALUES (6, 212);
INSERT INTO User_Task (user_id, task_id) VALUES (6, 215);
INSERT INTO User_Task (user_id, task_id) VALUES (7, 211);
INSERT INTO User_Task (user_id, task_id) VALUES (7, 213);
INSERT INTO User_Task (user_id, task_id) VALUES (8, 206);
INSERT INTO User_Task (user_id, task_id) VALUES (8, 214);
INSERT INTO User_Task (user_id, task_id) VALUES (1, 215);
INSERT INTO User_Task (user_id, task_id) VALUES (2, 209);
INSERT INTO User_Task (user_id, task_id) VALUES (3, 204);

COMMIT;
