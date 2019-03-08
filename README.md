# Picasso
![Cover picture](https://github.com/LorenzoBernaschina/Picasso/blob/master/Cover.png)

## Overview
‘Picasso’, is a drawing game designed to be used at any age but especially to develop kids skills, within a simple rule: you have to use only Rectangles, Triangles and Circles to make your compositions.
It is based on the idea that you can create almost everything using just these three fundamental shapes.

## Educational proposition
The aim is to get people’s minds used to the “pattern thinking”: a very important skill in computer science and many other fields.

‘Picasso’ is a “gamification” of this process: the shapes represent the basic patterns to start building more complex structures. 
For example, you can start with the simple representation of a tree as a sequence of triangles for the roots and the branches, rectangles for the trunk and circles for the foliage, and enjoy creating until you make very complicated draws.

Computer programmers are familiar with this way of thinking since the OOP is based on it, but society and our educational system looks still far from its adoption. This is why I would like to make kids involved through the game but, on a larger scale, I think about another use enabling people to have fun in expressing their creativity using only one finger.

## Instructions for playing
When you launch the game three buttons will appear on the left side of the screen.
Tap on one of them to reproduce the corresponding shape.
You can add as many different shapes as you wish.
If you tap twice on a shape, you get access to an Inspector for changing color, zPosition, size and rotation or even for deleting.
Once you have set your shape, drag it with the mouse to change its position on the screen and assemble it with others to make more complex figures.
Moreover if you tap on a blank space and drag, you can select multiple shapes and move them all together.
In addition, you can personalize the colors from the given palette or making them yourself by moving on the RGB lines.

## Technical accomplishments
The project is developed with Cocoa Touch, in particular I have used CoreGraphics and SpriteKit.
All things happens inside an SKScene. Shapes are drawn and managed using CGMutablePath and SKShapeNode.
The Inspector is a UIViewController object containing UISlider, UIButton and UILabel objects for changing shape’s parameters.

The background music is original and has been specially composed by my brother Leonardo using LogicPro.
