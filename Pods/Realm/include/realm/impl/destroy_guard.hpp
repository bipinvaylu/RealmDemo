/*************************************************************************
 *
 * REALM CONFIDENTIAL
 * __________________
 *
 *  [2011] - [2012] Realm Inc
 *  All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains
 * the property of Realm Incorporated and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Realm Incorporated
 * and its suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Realm Incorporated.
 *
 **************************************************************************/

#ifndef REALM_IMPL_DESTROY_GUARD_HPP
#define REALM_IMPL_DESTROY_GUARD_HPP

#include <realm/util/features.h>
#include <realm/array.hpp>

namespace realm {
namespace _impl {


/// Calls `ptr->destroy()` if the guarded pointer (`ptr`) is not null
/// when the guard is destroyed. For arrays (`T` = `Array`) this means
/// that the array is destroyed in a shallow fashion. See
/// `DeepArrayDestroyGuard` for an alternative.
template<class T> class DestroyGuard {
public:
    DestroyGuard() noexcept;

    DestroyGuard(T*) noexcept;

    ~DestroyGuard() noexcept;

    void reset(T*) noexcept;

    T* get() const noexcept;

    T* release() noexcept;

private:
    T* m_ptr;
};

typedef DestroyGuard<Array> ShallowArrayDestroyGuard;


/// Calls `ptr->destroy_deep()` if the guarded Array pointer (`ptr`)
/// is not null when the guard is destroyed.
class DeepArrayDestroyGuard {
public:
    DeepArrayDestroyGuard() noexcept;

    DeepArrayDestroyGuard(Array*) noexcept;

    ~DeepArrayDestroyGuard() noexcept;

    void reset(Array*) noexcept;

    Array* get() const noexcept;

    Array* release() noexcept;

private:
    Array* m_ptr;
};


/// Calls `Array::destroy_deep(ref, alloc)` if the guarded 'ref'
/// (`ref`) is not zero when the guard is destroyed.
class DeepArrayRefDestroyGuard {
public:
    DeepArrayRefDestroyGuard(Allocator&) noexcept;

    DeepArrayRefDestroyGuard(ref_type, Allocator&) noexcept;

    ~DeepArrayRefDestroyGuard() noexcept;

    void reset(ref_type) noexcept;

    ref_type get() const noexcept;

    ref_type release() noexcept;

private:
    ref_type m_ref;
    Allocator& m_alloc;
};





// Implementation:

// DestroyGuard<T>

template<class T> inline DestroyGuard<T>::DestroyGuard() noexcept:
    m_ptr(0)
{
}

template<class T> inline DestroyGuard<T>::DestroyGuard(T* ptr) noexcept:
    m_ptr(ptr)
{
}

template<class T> inline DestroyGuard<T>::~DestroyGuard() noexcept
{
    if (m_ptr)
        m_ptr->destroy();
}

template<class T> inline void DestroyGuard<T>::reset(T* ptr) noexcept
{
    if (m_ptr)
        m_ptr->destroy();
    m_ptr = ptr;
}

template<class T> inline T* DestroyGuard<T>::get() const noexcept
{
    return m_ptr;
}

template<class T> inline T* DestroyGuard<T>::release() noexcept
{
    T* ptr = m_ptr;
    m_ptr = nullptr;
    return ptr;
}


// DeepArrayDestroyGuard

inline DeepArrayDestroyGuard::DeepArrayDestroyGuard() noexcept:
    m_ptr(0)
{
}

inline DeepArrayDestroyGuard::DeepArrayDestroyGuard(Array* ptr) noexcept:
    m_ptr(ptr)
{
}

inline DeepArrayDestroyGuard::~DeepArrayDestroyGuard() noexcept
{
    if (m_ptr)
        m_ptr->destroy_deep();
}

inline void DeepArrayDestroyGuard::reset(Array* ptr) noexcept
{
    if (m_ptr)
        m_ptr->destroy_deep();
    m_ptr = ptr;
}

inline Array* DeepArrayDestroyGuard::get() const noexcept
{
    return m_ptr;
}

inline Array* DeepArrayDestroyGuard::release() noexcept
{
    Array* ptr = m_ptr;
    m_ptr = nullptr;
    return ptr;
}


// DeepArrayRefDestroyGuard

inline DeepArrayRefDestroyGuard::DeepArrayRefDestroyGuard(Allocator& alloc) noexcept:
    m_ref(0),
    m_alloc(alloc)
{
}

inline DeepArrayRefDestroyGuard::DeepArrayRefDestroyGuard(ref_type ref,
                                                          Allocator& alloc) noexcept:
    m_ref(ref),
    m_alloc(alloc)
{
}

inline DeepArrayRefDestroyGuard::~DeepArrayRefDestroyGuard() noexcept
{
    if (m_ref)
        Array::destroy_deep(m_ref, m_alloc);
}

inline void DeepArrayRefDestroyGuard::reset(ref_type ref) noexcept
{
    if (m_ref)
        Array::destroy_deep(m_ref, m_alloc);
    m_ref = ref;
}

inline ref_type DeepArrayRefDestroyGuard::get() const noexcept
{
    return m_ref;
}

inline ref_type DeepArrayRefDestroyGuard::release() noexcept
{
    ref_type ref = m_ref;
    m_ref = 0;
    return ref;
}


} // namespace _impl
} // namespace realm

#endif // REALM_IMPL_DESTROY_GUARD_HPP
