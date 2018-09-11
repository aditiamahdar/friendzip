# README

Programming Language: **Ruby**

Web Framework: **Ruby on Rails - API Only**

Database: **PostgreSQL**

Server URL: https://friendzip.herokuapp.com/

## API DOCUMENTATION

### 1. Add Friend
_Endpoint:_ `POST /friends`

_Body Params:_
```
{
  friends: [EMAIL, EMAIL]
}
```
---
### 2. Retrieve Friends List
_Endpoint:_ `GET /friends`

_Params:_
```
{
  email: EMAIL
}
```
---
### 3. Common Friends List
_Endpoint:_ `GET /friends/common`

_Params:_
```
{
  friends: [EMAIL, EMAIL]
}
```
---
### 4. Subscribe
_Endpoint:_ `POST /subscribes`

_Body Params:_
```
{
  requestor: EMAIL,
  target: EMAIL
}
```
---
### 5. Block
_Endpoint:_ `POST /blocks`

_Body Params:_
```
{
  requestor: EMAIL,
  target: EMAIL
}
```
---
### 6. Recipients List
_Endpoint:_ `POST /updates`

_Body Params:_
```
{
  sender: EMAIL,
  text: MESSAGE_CAN_CONTAIN_EMAIL_TO_MENTION
}
```
