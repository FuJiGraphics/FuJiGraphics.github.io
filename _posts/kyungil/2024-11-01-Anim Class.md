---
layout: post
title: Anim Class
data: 2024-11-01 10:14:00 +09:00
categories: [SFML, Feature]
tags: [sfml]
use_math: true
---

애니메이션을 프레임 규격 및 Duration에 맞게 sfml에서 재생 시켜주는 클래스 입니다.

# C++17 이상 버전부터 사용 가능

**이슈 사항**

- Origin 설정 시 설정된 프레임의 위치도 변화하는 문제있음
- ~~SetAnimSequence 네이밍이 Set이면 비우고 다시 저장해야하는데 Push_back 하는 부분 수정 
ㄴ 대안1) AddAnimSequence로 이름 변경~~ (해결)

**Example**

```cpp

// 애니메이션 객체 선언
fz::Anim animIdle;

// 초기화 구문
void Init 
{
  // 경로에서 텍스처를 로드한다.
	animIdle.LoadFromFile("graphics/playerAnimation.png");
	
	// 프레임 시퀀스 루틴을 설정한다.
	animIdle.SetAnimSequence(
	{ 0, 0, 32, 32 },                     // 프레임의 x, y, width, height
	4,                                    // 프레임간의 간격
	{ 0.1, 0.1, 0.1, 0.1, 0.1, 0.6 },     // 프레임 별 재생 시간
	6);                                   // 생성할 프레임 개수
	
	// 역순 시퀀스를 기존 시퀀스에 추가한다. 
	animIdle.AddAnimSequenceRev(
	{  0, 0, 32, 32 },
	 4, 
	 { 0.1, 0.1, 0.1, 0.1, 0.1, 0.6 }, 
	 6);
	
	animIdle.SetScale(2.0f, 2.0f);
	animIdle.SetPosition({1920.0f * 0.5f + 80.0f, 560.0f});
}	

// 게임 루프 업데이트
void Update(float deltaTime)
{
	animIdle.Update(deltaTime);
}

// 게임 루프 Draw
void Draw(sf::RenderWindow& window)
{
	if (!isAlive)
	{
		window.draw(spriteDie);
		return;
	}
	else if (side == Sides::Right)
	{
			animIdle.SetPosition({ 1920.0f * 0.5f + 480.0f, 560.0f });
			animIdle.SetFlipX(true);
			animIdle.Draw(window);
	}
	else if (side == Sides::Left)
	{
			animIdle.SetPosition({ 1920.0f * 0.5f - 480.0f, 560.0f });
			animIdle.SetFlipX(false);
			animIdle.Draw(window);
	}
}
	
```

## public 멤버 변수 설명

- **bool** Activated
애니메이션 그리기 기능을 비활성화 합니다
- **bool** Repeat
애니메이션을 반복합니다.

## public 멤버 함수 설명

- **bool** LoadFromFile**(const std::string& path);**  
경로에서 텍스처를 로드합니다.
- **void** AddFrame**(const Frame& frame);**  
IntRect{x, y, width, height}와 duration(지속 시간)으로 이루어진 frame을 입력받습니다.  
- **void** SetName**(const std::string& name);**  
이름을 설정합니다.
- **void** SetPosition**(const sf::Vector2f& pos);**  
위치를 설정합니다.
- **void** SetScale**(const sf::Vector2f& scale);**  
스케일을 설정합니다.
- **void** SetScale**(float scaleX, float scaleY);**  
스케일을 설정합니다.
- **void** SetFlipX**(bool enabled);**  
enabled가 true일 경우 텍스처를 X축 반전
- **void** SetFlipY**(bool enabled);**  
enabled가 true일 경우 텍스처를 Y축 반전
- **std::string** GetName**() const;**  
현재 ****이름 반환
- **sf::Vector2f** GetPosition**() const;**  
현재 위치 반환
- **sf::Vector2f** GetScale**() const;**  
현재 스케일 반환
- **bool** IsFlipX**() const;**  
X축 반전 상태일 경우 true
- **bool** IsFlipY**() const;**  
Y축 반전 상태일 경우 true
- **bool** IsFrameEnd**() const;**  
시퀀스 프레임이 모두 재생되었을 경우 true , 첫 프레임부터 재시작 시 false
- **void** SetAnimSequence**(const sf::IntRect& rect, int stride, const std::vector<double>& durations, int count);**  
시퀀스 프레임을일정한 간격(stride)만큼 설정합니다.  
rect: 불러올 프레임의 크기  
stride: 프레임 간의 간격  
durations: 각 프레임 별 재생 시간  
count: 불러올 프레임 개수
- **void** SetAnimSequenceRev**(const sf::IntRect& rect, int stride, const std::vector<double>& durations, int count);**  
시퀀스 프레임을 일정한 간격(stride)만큼 역순으로 설정합니다.  
rect: 불러올 프레임의 크기  
stride: 프레임 간의 간격  
durations: 각 프레임 별 재생 시간  
count: 불러올 프레임 개수
- **void** SetAnimSequence**(const sf::IntRect& rect, int stride, double duration, int count);**  
시퀀스 프레임을 일정한 간격(stride)만큼 설정합니다.  
rect: 불러올 프레임의 크기  
stride: 프레임 간의 간격  
duration: 모든 프레임의 균일 재생 시간  
count: 불러올 프레임 개수
- **void** SetAnimSequenceRev**(const sf::IntRect& rect, int stride, double duration, int count);**  
시퀀스 프레임을 일정한 간격(stride)만큼 역순으로 설정합니다.  
rect: 불러올 프레임의 크기  
stride: 프레임 간의 간격  
duration: 모든 프레임의 균일 재생 시간  
count: 불러올 프레임 개수
- **void** AddAnimSequence**(const sf::IntRect& rect, int stride, const std::vector<double>& durations, int count);**  
시퀀스 프레임을 일정한 간격(stride)만큼 기존 시퀀스에 추가합니다.  
rect: 불러올 프레임의 크기  
stride: 프레임 간의 간격  
durations: 각 프레임 별 재생 시간  
count: 불러올 프레임 개수
- **void** AddAnimSequenceRev**(const sf::IntRect& rect, int stride, const std::vector<double>& durations, int count);**  
시퀀스 프레임을 일정한 간격(stride)만큼 역순으로 기존 시퀀스에 추가합니다.  
rect: 불러올 프레임의 크기  
stride: 프레임 간의 간격  
durations: 각 프레임 별 재생 시간  
count: 불러올 프레임 개수
- **void** AddAnimSequence**(const sf::IntRect& rect, int stride, double duration, int count);**  
시퀀스 프레임을 일정한 간격(stride)만큼 설정합니다.  
rect: 불러올 프레임의 크기  
stride: 프레임 간의 간격  
duration: 모든 프레임의 균일 재생 시간  
count: 불러올 프레임 개수
- **void** AddAnimSequenceRev**(const sf::IntRect& rect, int stride, double duration, int count);**  
시퀀스 프레임을 일정한 간격(stride)만큼 역순으로 기존 시퀀스에 추가합니다.  
rect: 불러올 프레임의 크기  
stride: 프레임 간의 간격  
duration: 모든 프레임의 균일 재생 시간  
count: 불러올 프레임 개수
- **void** Update**(float dt);**  
매 프레임마다 이전 프레임에 대한 DeltaTime으로 애니메이션을 갱신합니다.
- **void** Reset**();**  
재생 프레임을 첫 프레임으로 변경합니다.  
위치 데이터와 같은 메타 데이터는 변경되지 않습니다.  
- **void** Draw**(sf::RenderWindow& window);**  
애니메이션을 그립니다.

[Anim.h](https://prod-files-secure.s3.us-west-2.amazonaws.com/998baec5-4c1f-4a0b-8c50-f1ec1a303577/1ed3f46c-d753-4a87-89f7-d4daeabe2f1e/Anim.h)
[Anim.cpp](https://prod-files-secure.s3.us-west-2.amazonaws.com/998baec5-4c1f-4a0b-8c50-f1ec1a303577/d93ef120-b25a-4b8a-83bc-3c6fa9d4a534/Anim.cpp)
