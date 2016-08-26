import ReactiveCocoa
import Result
import Nimble

public func sendNext<T: SignalProducerType, V: Equatable where T.Value == V>(next: V) -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.expected = "expected producer"
        failureMessage.postfixMessage = "send next: \(next)"
        guard let producer = try actualExpression.evaluate() else {
            return false
        }
        var nextDidCall = false
        producer.start { event in
            if case .Next(let value) = event where next == value {
                nextDidCall = true
            }
            failureMessage.actualValue = "\(event)"
        }
        return nextDidCall
    }
}

public func sendNextAndComplete<T: SignalProducerType, V: Equatable where T.Value == V>(next: V) -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.expected = "expected producer"
        failureMessage.postfixMessage = "send next: \(next) and complete"
        var message = ""
        guard let producer = try actualExpression.evaluate() else {
            return false
        }
        var nextDidCall = false
        var completeDidCall = false
        producer.start { event in
            if case .Next(let value) = event where next == value {
                nextDidCall = true
            }
            if case .Completed = event {
                completeDidCall = true
            }
            message += "\(event) "
            failureMessage.actualValue = message
        }
        return nextDidCall && completeDidCall
    }
}

public func sendNextAndComplete<T: SignalProducerType where T.Value == Void>() -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.expected = "expected producer"
        failureMessage.postfixMessage = "send next and complete"
        var message = ""
        guard let producer = try actualExpression.evaluate() else {
            return false
        }
        var nextDidCall = false
        var completeDidCall = false
        producer.start { event in
            if case .Next = event {
                nextDidCall = true
            }
            if case .Completed = event {
                completeDidCall = true
            }
            message += "\(event) "
            failureMessage.actualValue = message
        }
        return nextDidCall && completeDidCall
    }
}

public func sendNext<T: SignalProducerType where T.Value == Void>() -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.expected = "expected producer"
        failureMessage.postfixMessage = "send next"
        guard let producer = try actualExpression.evaluate() else {
            return false
        }
        var nextDidCall = false
        producer.start { event in
            if case .Next = event {
                nextDidCall = true
            }
            failureMessage.actualValue = "\(event)"
        }
        return nextDidCall
    }
}

public func complete<T: SignalProducerType>() -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.expected = "expected producer"
        failureMessage.postfixMessage = "complete"
        guard let producer = try actualExpression.evaluate() else {
            return false
        }
        var completeDidCall = false
        producer.start { event in
            if case .Completed = event {
                completeDidCall = true
            }
            failureMessage.actualValue = "\(event)"
        }
        return completeDidCall
    }
}

public func fail<T: SignalProducerType>() -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.expected = "expected producer"
        failureMessage.postfixMessage = "fail"
        guard let producer = try actualExpression.evaluate() else {
            return false
        }
        var failDidCall = false
        producer.start { event in
            if case .Failed(_) = event {
                failDidCall = true
            }
            failureMessage.actualValue = "\(event)"
        }
        return failDidCall
    }
}

public func failWithError<T: SignalProducerType, E: ErrorType where T.Error == E, E: Equatable>(error: E) -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.expected = "expected producer"
        failureMessage.postfixMessage = "failWithError: \(error)"
        guard let producer = try actualExpression.evaluate() else {
            return false
        }
        var failDidCall = false
        producer.start { event in
            if case .Failed(let err) = event where err == error {
                failDidCall = true
            }
            failureMessage.actualValue = "\(event)"
        }
        return failDidCall
    }
}

public func failWithError<T: SignalProducerType, E: ErrorType where T.Error == ActionError<E>, E: Equatable>(error: ActionError<E>) -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.expected = "expected producer"
        failureMessage.postfixMessage = "failWithError: \(error)"
        guard let producer = try actualExpression.evaluate() else {
            return false
        }
        var failDidCall = false
        producer.start { event in
            if case .Failed(let err) = event where err == error {
                failDidCall = true
            }
            failureMessage.actualValue = "\(event)"
        }
        return failDidCall
    }
}

/////************************************************//////

public func sendNext<T: SignalType, V: Equatable where T.Value == V>(next: V) -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.expected = "expected producer"
        failureMessage.postfixMessage = "send next: \(next)"
        guard let producer = try actualExpression.evaluate() else {
            return false
        }
        var nextDidCall = false
        producer.observe { event in
            if case .Next(let value) = event where next == value {
                nextDidCall = true
            }
            failureMessage.actualValue = "\(event)"
        }
        return nextDidCall
    }
}

public func sendNextAndComplete<T: SignalType, V: Equatable where T.Value == V>(next: V) -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.expected = "expected producer"
        failureMessage.postfixMessage = "send next: \(next) and complete"
        var message = ""
        guard let producer = try actualExpression.evaluate() else {
            return false
        }
        var nextDidCall = false
        var completeDidCall = false
        producer.observe { event in
            if case .Next(let value) = event where next == value {
                nextDidCall = true
            }
            if case .Completed = event {
                completeDidCall = true
            }
            message += "\(event) "
            failureMessage.actualValue = message
        }
        return nextDidCall && completeDidCall
    }
}

public func sendNextAndComplete<T: SignalType where T.Value == Void>() -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.expected = "expected producer"
        failureMessage.postfixMessage = "send next and complete"
        var message = ""
        guard let producer = try actualExpression.evaluate() else {
            return false
        }
        var nextDidCall = false
        var completeDidCall = false
        producer.observe { event in
            if case .Next = event {
                nextDidCall = true
            }
            if case .Completed = event {
                completeDidCall = true
            }
            message += "\(event) "
            failureMessage.actualValue = message
        }
        return nextDidCall && completeDidCall
    }
}

public func sendNext<T: SignalType where T.Value == Void>() -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.expected = "expected producer"
        failureMessage.postfixMessage = "send next"
        guard let producer = try actualExpression.evaluate() else {
            return false
        }
        var nextDidCall = false
        producer.observe { event in
            if case .Next = event {
                nextDidCall = true
            }
            failureMessage.actualValue = "\(event)"
        }
        return nextDidCall
    }
}

public func complete<T: SignalType>() -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.expected = "expected producer"
        failureMessage.postfixMessage = "complete"
        guard let producer = try actualExpression.evaluate() else {
            return false
        }
        var completeDidCall = false
        producer.observe { event in
            if case .Completed = event {
                completeDidCall = true
            }
            failureMessage.actualValue = "\(event)"
        }
        return completeDidCall
    }
}

public func fail<T: SignalType>() -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.expected = "expected producer"
        failureMessage.postfixMessage = "fail"
        guard let producer = try actualExpression.evaluate() else {
            return false
        }
        var failDidCall = false
        producer.observe { event in
            if case .Failed(_) = event {
                failDidCall = true
            }
            failureMessage.actualValue = "\(event)"
        }
        return failDidCall
    }
}

public func failWithError<T: SignalType, E: ErrorType where T.Error == E, E: Equatable>(error: E) -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.expected = "expected producer"
        failureMessage.postfixMessage = "failWithError: \(error)"
        guard let producer = try actualExpression.evaluate() else {
            return false
        }
        var failDidCall = false
        producer.observe { event in
            if case .Failed(let err) = event where err == error {
                failDidCall = true
            }
            failureMessage.actualValue = "\(event)"
        }
        return failDidCall
    }
}

public func failWithError<T: SignalType, E: ErrorType where T.Error == ActionError<E>, E: Equatable>(error: ActionError<E>) -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.expected = "expected producer"
        failureMessage.postfixMessage = "failWithError: \(error)"
        guard let producer = try actualExpression.evaluate() else {
            return false
        }
        var failDidCall = false
        producer.observe { event in
            if case .Failed(let err) = event where err == error {
                failDidCall = true
            }
            failureMessage.actualValue = "\(event)"
        }
        return failDidCall
    }
}
