from collections import Counter
import turtle
from scipy.stats import entropy


class Node:
    def __init__(self, symbol: str, freq: int, left=None, right=None):
        self.symbol = '[space]' if symbol.isspace() else symbol
        self.freq = freq
        self.left = left
        self.right = right
        self.huff = ''


def getNodes(node: Node, val='', resultDict={}) -> dict:
    newVal = val + str(node.huff)
    if node.left:
        getNodes(node.left, newVal, resultDict)
    if node.right:
        getNodes(node.right, newVal, resultDict)
    if(not node.left and not node.right):
        # print(node.symbol, newVal)
        resultDict.update({node.symbol: newVal})
    return resultDict


def createTree(word: str) -> Node:
    nodes = [Node(symbol, freq)
             for symbol, freq in dict(Counter(word)).items()]
    while len(nodes) > 1:
        # sort ascending by freq
        nodes = sorted(nodes, key=lambda x: x.freq)
        # get two smallest nodes
        left = nodes[0]
        right = nodes[1]
        # assign direction
        left.huff, right.huff = '0', '1'
        # create parent node
        newNode = Node('', left.freq + right.freq, left, right)
        # remove 2 smallest nodes
        nodes = nodes[2:]
        nodes.append(newNode)
    return nodes[0]


def drawTree(root: Node):
    def height(root: Node):
        return 1 + max(height(root.left), height(root.right)) if root else -1

    def jumpto(x: int, y: int):
        t.penup()
        t.goto(x, y)
        t.pendown()

    def draw(node: Node, x: int, y: int, dx: int):
        if node:
            t.goto(x, y)
            jumpto(x, y-20)
            t.write(node.freq, align='center', font=('Verdana', 12, 'normal'))
            if node.symbol:
                jumpto(x, y-38)
                t.write(node.symbol, align='center',
                        font=('Verdana', 12, 'normal'))
            draw(node.left, x-dx, y-60, dx/2)
            jumpto(x, y-20)
            draw(node.right, x+dx, y-60, dx/2)
    t = turtle.Turtle()
    t.speed(0)
    turtle.delay(0)
    h = height(root)
    jumpto(0, 30*h)
    draw(root, 0, 30*h, 40*h)
    t.hideturtle()
    turtle.mainloop()


def textEntropy(text: str) -> float:
    # we only consider UTF8 characters to compute the text entropy
    pk = list(Counter(text).values())
    if sum(pk) == 0:
        return None
    else:
        return entropy(pk, base=2)


def averageCodeWordLength(word: str, markCodeDict: dict) -> float:
    # markCodeDict contains symbol and it's huffman code e.g. a: '00'
    # markProbDict contains symbol and it's probability e.g. a: 0.125
    markProbDict = {key: value / len(word)
                    for key, value in dict(Counter(word)).items()}
    if ' ' in markProbDict:
        markProbDict["[space]"] = markProbDict.pop(' ')
    return sum([markProbDict[key] * len(markCodeDict[key]) for key in markProbDict])


if __name__ == '__main__':
    word = 'A' * 10 + 'E' * 15 + 'I' * 12 + 'S' * 3 + 'T' * 4 + 'P' * 13 + ' '
    word = 'Betty Botter bought some butter; But she said "this butter''s bitter!" If i put it in my batter It would make my batter bitter. So she bought a bit of butter Better than the bitter butter. Put it in the bitter tabber Make the bitter batter better. So t''was better Betty Botter Bought a bit of better butter.'

    print(dict(Counter(word)))
    node = createTree(word)
    markCodeDict = getNodes(node)
    # sort by code length
    [print(f'{symbol}: {code}')
     for symbol, code in dict(sorted(markCodeDict.items(), key=lambda x: len(x[1]))).items()]

    print(f'Entropy = {textEntropy(word)}')
    print(
        f'Average code word length = {averageCodeWordLength(word, markCodeDict)}')
    print(
        f'Efficency = {round(textEntropy(word) / averageCodeWordLength(word, markCodeDict) * 100, 2)}%')
    drawTree(node)
