#ifndef MMZ_STUB_ASSERT_H
#define MMZ_STUB_ASSERT_H

// Provide a lightweight static_assert for translate-c
#ifndef static_assert
#define static_assert(expr, ...) typedef char static_assertion_##__LINE__[(expr)?1:-1]
#endif

#endif // MMZ_STUB_ASSERT_H
