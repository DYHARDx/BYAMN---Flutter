const String byamnHomeJson = '''
{
  "heroTitle": "Aggregate, Identify, and Apply all in one place",
  "heroSubtitle": "Your all-in-one hub for the best internships, courses, and resources. Verified daily to help you build your future.",
  "stats": [
    {"value": "100+", "label": "Free Courses Added"},
    {"value": "50+", "label": "Live Hackathons"},
    {"value": "50k+", "label": "Time Saved (Hours)"},
    {"value": "50+", "label": "Platforms Scanned"}
  ],
  "features": [
    {"title": "We Aggregate Sources", "description": "We track trusted platforms every day."},
    {"title": "We Verify Quality", "description": "We filter useful and student-friendly opportunities."},
    {"title": "You Apply Directly", "description": "You are redirected to the official application page."}
  ],
  "testimonials": [
    {
      "name": "Priti Kumari",
      "role": "Computer Science Student",
      "quote": "BYAMN saved me hours of searching. I found the perfect free Udemy course and an internship in one place!",
      "imageUrl": "https://i.pravatar.cc/150?u=priti"
    },
    {
      "name": "Ananya Gupta",
      "role": "Aspiring Developer",
      "quote": "Instead of checking Unstop and Fundit separately, I just come here. The curated hackathon list is amazing.",
      "imageUrl": "https://i.pravatar.cc/150?u=ananya"
    },
    {
      "name": "Sahil Verma",
      "role": "Final Year Student",
      "quote": "The ultimate time-saver! I participated in a hackathon found through BYAMN and it boosted my resume instantly.",
      "imageUrl": "https://i.pravatar.cc/150?u=sahil"
    }
  ],
  "faq": [
    {
      "question": "What is BYAMN?",
      "answer": "BYAMN is an all-in-one opportunity platform that aggregates internships, courses, jobs and resources from trusted sources."
    },
    {
      "question": "Are the courses actually free?",
      "answer": "Yes, many listings are fully free and clearly marked. We also include premium options with transparent labels."
    },
    {
      "question": "Which platforms do you track?",
      "answer": "We track multiple platforms including Udemy, Coursera, Google, Unstop, LinkedIn, Internshala and more."
    },
    {
      "question": "Do I need to pay to use BYAMN?",
      "answer": "No, BYAMN core discovery experience is free for students."
    }
  ]
}
''';

const String byamnOpportunitiesJson = '''
[
  {
    "id": "course_1",
    "type": "course",
    "title": "Flutter Development Bootcamp",
    "provider": "Udemy",
    "category": "Mobile Development",
    "duration": "24 hours",
    "rating": 4.7,
    "tags": ["Flutter", "Dart", "UI"],
    "url": "https://www.byamn.in/courses",
    "imageUrl": "https://picsum.photos/seed/course1/600/400",
    "location": "Remote",
    "summary": "Build complete Flutter apps with practical projects and portfolio-ready UI.",
    "isFree": true
  },
  {
    "id": "course_2",
    "type": "course",
    "title": "Google Cloud Skills Path",
    "provider": "Google",
    "category": "Cloud",
    "duration": "16 hours",
    "rating": 4.5,
    "tags": ["Cloud", "Beginner"],
    "url": "https://www.byamn.in/courses",
    "imageUrl": "https://picsum.photos/seed/course2/600/400",
    "location": "Remote",
    "summary": "Hands-on cloud fundamentals path with labs and verification badges.",
    "isFree": true
  },
  {
    "id": "course_3",
    "type": "course",
    "title": "System Design Fundamentals",
    "provider": "Coursera",
    "category": "Backend",
    "duration": "10 hours",
    "rating": 4.8,
    "tags": ["System Design", "Interview"],
    "url": "https://www.byamn.in/courses",
    "imageUrl": "https://picsum.photos/seed/course3/600/400",
    "location": "Remote",
    "summary": "Master scalable architecture, APIs and caching for interviews and real systems.",
    "isFree": false
  },
  {
    "id": "intern_1",
    "type": "internship",
    "title": "SDE Intern",
    "provider": "LinkedIn",
    "category": "Software Engineering",
    "duration": "3 months",
    "rating": 4.4,
    "tags": ["Remote", "Stipend"],
    "url": "https://www.byamn.in/internships",
    "imageUrl": "https://picsum.photos/seed/intern1/600/400",
    "location": "Bengaluru",
    "summary": "Work on production features and improve full-stack development skills.",
    "isFree": true
  },
  {
    "id": "intern_2",
    "type": "internship",
    "title": "Frontend Intern",
    "provider": "Internshala",
    "category": "Web Development",
    "duration": "6 months",
    "rating": 4.3,
    "tags": ["React", "Hybrid"],
    "url": "https://www.byamn.in/internships",
    "imageUrl": "https://picsum.photos/seed/intern2/600/400",
    "location": "Hybrid",
    "summary": "Build polished frontend modules with modern tooling and mentor support.",
    "isFree": true
  },
  {
    "id": "intern_3",
    "type": "internship",
    "title": "Data Analyst Intern",
    "provider": "Unstop",
    "category": "Data",
    "duration": "4 months",
    "rating": 4.6,
    "tags": ["SQL", "Excel", "Python"],
    "url": "https://www.byamn.in/internships",
    "imageUrl": "https://picsum.photos/seed/intern3/600/400",
    "location": "Remote",
    "summary": "Analyze datasets and build decision-ready dashboards for business teams.",
    "isFree": true
  },
  {
    "id": "job_1",
    "type": "job",
    "title": "Junior Flutter Developer",
    "provider": "Startup India",
    "category": "Mobile",
    "duration": "Full Time",
    "rating": 4.2,
    "tags": ["Flutter", "Full-Time"],
    "url": "https://www.byamn.in/jobs",
    "imageUrl": "https://picsum.photos/seed/job1/600/400",
    "location": "Remote",
    "summary": "Maintain and ship features in mobile apps for large student audience.",
    "isFree": true
  },
  {
    "id": "competition_1",
    "type": "competition",
    "title": "National Hackathon Sprint",
    "provider": "Unstop",
    "category": "Hackathon",
    "duration": "36 hours",
    "rating": 4.6,
    "tags": ["Hackathon", "Team"],
    "url": "https://www.byamn.in/hackathons",
    "imageUrl": "https://picsum.photos/seed/hack1/600/400",
    "location": "Online",
    "summary": "Build and pitch innovative ideas with mentors and prizes.",
    "isFree": true
  },
  {
    "id": "tool_1",
    "type": "tool",
    "title": "AI Resume Builder",
    "provider": "BYAMN Tools",
    "category": "Career Tool",
    "duration": "Instant",
    "rating": 4.5,
    "tags": ["AI", "Resume", "Tool"],
    "url": "https://www.byamn.in/tools",
    "imageUrl": "https://picsum.photos/seed/tool1/600/400",
    "location": "Web",
    "summary": "Generate ATS-friendly resumes with one-click role customization.",
    "isFree": true
  }
]
''';

const String byamnNetworkUsersJson = '''
[
  {
    "id": "user_1",
    "name": "Aman Singh",
    "role": "Founder at BYAMN",
    "location": "Gorakhpur, India",
    "imageUrl": "https://picsum.photos/seed/user1/300/300",
    "skills": ["Product", "Community", "Startups"]
  },
  {
    "id": "user_2",
    "name": "Sana Iqbal",
    "role": "Frontend Developer",
    "location": "Delhi, India",
    "imageUrl": "https://picsum.photos/seed/user2/300/300",
    "skills": ["Flutter", "React", "UI"]
  },
  {
    "id": "user_3",
    "name": "Rohit Verma",
    "role": "Backend Engineer",
    "location": "Bengaluru, India",
    "imageUrl": "https://picsum.photos/seed/user3/300/300",
    "skills": ["Node", "Python", "System Design"]
  }
]
''';

const String byamnNotificationsJson = '''
[
  {
    "id": "n1",
    "title": "New internships added",
    "message": "26 fresh internship opportunities were verified today.",
    "time": "2m ago",
    "isUnread": true
  },
  {
    "id": "n2",
    "title": "Course alert",
    "message": "Top rated free Flutter course is now available.",
    "time": "1h ago",
    "isUnread": true
  },
  {
    "id": "n3",
    "title": "Hackathon reminder",
    "message": "Deadline for Code Sprint Challenge ends tonight.",
    "time": "3h ago",
    "isUnread": false
  }
]
''';
