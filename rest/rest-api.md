# Demo Restful CRUD API Spring Boot Application
## Overview
- **Technical**: **Spring Boot 2.7.8**
  - [Spring Web](https://docs.spring.io/spring-boot/docs/2.7.8/reference/htmlsingle/#web)
  - [Spring Data JPA](https://docs.spring.io/spring-boot/docs/2.7.8/reference/htmlsingle/#data.sql.jpa-and-spring-data)
- **SQL**
  - [H2 Database](https://www.h2database.com/html/main.html)
- **Tool**
  - [Lombok](https://projectlombok.org/)
## Structure of application
<pre>
├── <b>src</b>
│   ├── <b>main</b>
│   │   ├── <b>java</b>
│   │   │   ├── <b>com.likelion.rest</b>
│   │   │   │   └── controller
│   │   │   │   └── entity
│   │   │   │   └── repository
│   │   │   │   └── service
│   ├── <b>resources</b>
│   ├── <b>test</b>
├── ...
</pre>
## API Collection
![API Collection](result/all-api-tutorial.png)
<img src="result/all-api-tutorial.png" width="1280" height="720" title="Restful CRUD API" alt="API collection of demo application">
- Create Tutorial: [POST /api/tutorials](#api-1)
- Find All Tutorials: [GET /api/tutorials](#api-2)
- Find Tutorial By Id: [GET /api/tutorials/{id}](#api-3)
- Update Tutorial: [PUT: /api/tutorials/{id}](#api-4)
- Delete Tutorial By Id: [DELETE: /api/tutorials/{id}](#api-5)
- Delete All Tutorials: [DELETE: /api/tutorials](#api-6)
- Find Tutorial By Published: [GET: /api/tutorials/published](#api-7)
- Find Tutorial By Title: [GET: /api/tutorials?title={title}]](#api-8)


## Results
### 1. API Create Tutorial
#### POST /api/tutorials
![Create Tutorial](result/create-tutorial.png)

### 2. API Find All Tutorials
#### GET /api/tutorials
![Find All Tutorial](result/find-all-tutorials.png)

### 3. API Find Tutorial By Id
#### GET /api/tutorials/{id}
![Find Tutorial By Id](result/find-tutorial-by-id.png)

### 4. API Update Tutorial
#### PUT: /api/tutorials/{id}
![Update Tutorial](result/create-tutorial.png)

### 5. API Delete Tutorial By Id
#### DELETE: /api/tutorials/{id}
![Delete Tutorial By Id](result/delete-tutorial-by-id.png)

### 6. API Delete All Tutorials
#### DELETE: /api/tutorials
![Delete All Tutorials](result/delete-all-tutorials.png)

### 7. API Find Tutorial By Published
#### GET: /api/tutorials/published
![Find Tutorial By Published](result/find-tutorial-by-published.png)

### 8. Find Tutorial By Title
#### GET: /api/tutorials?title={title}
![Find Tutorial By Title](result/find-tutorial-by-title.png)

### 9. Click [json postman collection file](result/tutorial_demo.postman_collection.json) to see