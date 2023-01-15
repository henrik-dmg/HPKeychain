import Foundation

@resultBuilder
public enum QueryItemBuilder {

    public static func buildBlock(_ components: [QueryItem]...) -> [QueryItem] {
        components.flatMap { $0 }
    }

    /// Add support for both single and collections of constraints.
    public static func buildExpression(_ expression: QueryItem) -> [QueryItem] {
        [expression]
    }

    public static func buildExpression(_ expression: [QueryItem]) -> [QueryItem] {
        expression
    }

    /// Add support for optionals.
    public static func buildOptional(_ components: [QueryItem]?) -> [QueryItem] {
        components ?? []
    }

    /// Add support for if statements.
    public static func buildEither(first components: [QueryItem]) -> [QueryItem] {
        components
    }

    public static func buildEither(second components: [QueryItem]) -> [QueryItem] {
        components
    }

    public static func buildArray(_ components: [[QueryItem]]) -> [QueryItem] {
        components.flatMap { $0 }
    }

    public static func buildLimitedAvailability(_ component: [QueryItem]) -> [QueryItem] {
        component
    }

}
